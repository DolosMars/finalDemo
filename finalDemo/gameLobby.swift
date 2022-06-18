//
//  gameLobby.swift
//  finalDemo
//
//  Created by User06 on 2022/5/27.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift
import NukeUI
/*struct userProfile: Codable, Identifiable {
 @DocumentID var id: String?
 let name: String
 }*/

struct gameLobby: View {
    @Binding var showGameLobbyView:Bool
    @State private var showUserDataView:Bool = false
    @State private var user:User?
    @State private var name = ""
    @State private var photo = ""
    @State private var showPhotoStickers:Bool = false
    
    var body: some View {
        VStack{
            HStack{
                if showPhotoStickers{
                    LazyImage(source:photo)
                        //.resizable()
                        //.scaledToFill()
                        .frame(width: 100, height: 100)
                        .padding()
                    
                }else{
                    Image(systemName: photo)
                        .resizable()
                        //.scaledToFill()
                        .frame(width: 100, height: 100)
                        .padding()
                }
                
                VStack{
                    Text(name)
                        .font(.system(size: 30))
                        .foregroundColor(.yellow)
                        .bold()
                    Text("")
                    Button(action: {
                        showUserDataView = true
                    }, label: {
                        Text("點擊編輯")
                            .font(.system(size: 20))
                            .foregroundColor(.blue)
                            .bold()
                    }).fullScreenCover(isPresented: $showUserDataView) {
                        userData( showUserDataView: $showUserDataView)
                    }
                }
                Spacer()
                HStack{
                    Spacer()
                    VStack{
                        Spacer()
                        Button(action: {
                            //玩遊戲
                            
                        }, label: {
                            Text("Play")
                                .font(.system(size: 20))
                                .foregroundColor(.blue)
                                .bold()
                        })
                        
                        Button(action: {
                            //登出
                            do {
                               //try Auth.auth().signOut()
                                showGameLobbyView = false
                            } catch {
                               print(error)
                            }
                        }, label: {
                            Text("Quit")
                                .font(.system(size: 20))
                                .foregroundColor(.blue)
                                .bold()
                        })
                        
                        Spacer()
                    }
                    Spacer()
                }
            }
            
            Spacer()
        }.background(Image("slayTheSpire2").scaledToFill().opacity(0.4))
        .onAppear{
            let user = Auth.auth().currentUser
            
            
            let db = Firestore.firestore()
            let documentReference =
                db.collection("userData").document(user!.uid)
            documentReference.getDocument { document, error in
                
                guard let document = document,
                      document.exists,
                      var data = try? document.data(as: userProfile.self)
                
                else {
                    return
                }
                print(data.name)
                if (data.name == "") {
                    name = "ANONYMOUS"
                }
                else {
                    name = data.name
                }
                
                if (data.photoStickers == "") {
                    photo = "person.crop.circle.fill"
                    showPhotoStickers = false
                }else{
                    photo = data.photoStickers
                    showPhotoStickers = true
                }
            }
            
        }
    }
}

struct gameLobby_Previews: PreviewProvider {
    static var previews: some View {
        gameLobby(showGameLobbyView: .constant(true))
            .previewLayout(.fixed(width: 844, height: 390))
    }
}
