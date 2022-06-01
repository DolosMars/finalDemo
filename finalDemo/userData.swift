//
//  userData.swift
//  finalDemo
//
//  Created by User06 on 2022/5/28.
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
struct userData: View {
    
    @Binding var showUserDataView:Bool
    @State private var showCustomRoleView:Bool = false
    @State private var changeName:Bool = false
    @State private var setName:String = ""
    @State private var user:User?
    @State private var photo = ""
    @State private var showPhotoStickers:Bool = false
    @State private var showNameAlert:Bool = false
    
    var body: some View {
        NavigationView {
            HStack{
                ZStack{
                    
                    
                    if showPhotoStickers{
                        LazyImage(source:photo)
                            //.resizable()
                            .frame(width: 300, height: 300)
                            .padding()
                        
                    }else{
                        Image(systemName: photo)
                            .resizable()
                            .frame(width: 300, height: 300)
                            .padding()
                    }
                    Button(action: {
                        //去客製化頁面
                        showCustomRoleView = true
                    }, label: {
                        Image(systemName: "square.and.pencil")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 50, height: 50)
                            .foregroundColor(.yellow)
                            .position(x: 270, y: 270)
                            .padding()
                    }).fullScreenCover(isPresented: $showCustomRoleView) {
                        customRole( showCustomRoleView: $showCustomRoleView)
                    }
                }
                VStack{
                        HStack{
                            if changeName == true
                            {
                                TextField("請輸入名稱", text: $setName)
                                Spacer()
                                Button(action: {
                                    changeName = false
                                }, label: {
                                    Text("取消")
                                })
                                Button(action: {
                                    
                                    changeName = false
                                    
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
                                        data.name = setName
                                        do {
                                            try documentReference.setData(from: data)
                                        } catch {
                                            print(error)
                                        }
                                        
                                    }
                                    showNameAlert = true
                                }, label: {
                                    Text("確定")
                                })
                            }else{
                                Text("名稱 \(setName)")
                                Spacer()
                            }
                            
                            Button(action: {
                                //修改姓名
                                changeName = true
                            }, label: {
                                Image(systemName: "square.and.pencil")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 30, height: 30)
                                .foregroundColor(.blue)
                            })
                            
                        }
                        
                        /*HStack{
                            Text("性別")
                            Spacer()
                            Button(action: {
                                //修改性別
                            }, label: {
                                Image(systemName: "square.and.pencil")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 30, height: 30)
                                .foregroundColor(.blue)
                            })
                            
                        }*/
                        
                        /*HStack{
                            Text("生日")
                            Spacer()
                            Button(action: {
                                //修改姓名
                            }, label: {
                                Image(systemName: "square.and.pencil")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 30, height: 30)
                                .foregroundColor(.blue)
                            })
                            
                        }*/
                        /*HStack{
                            Text("稱號")
                            Spacer()
                            Button(action: {
                                //修改姓名
                            }, label: {
                                Image(systemName: "square.and.pencil")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 30, height: 30)
                                .foregroundColor(.blue)
                            })
                            
                        }
                        
                        Text("加入遊戲的時間")*/
                        
                        Text("")
                        Button(action: {
                            showUserDataView = false
                        }, label: {
                            Text("返回上一頁")
                            
                        })
                        
                        /*Button(action: {
                            //登出
                            do {
                               try Auth.auth().signOut()
                            } catch {
                               print(error)
                            }
                        }, label: {
                            Text("登出")
                        })*/
                        
                    }.alert(isPresented: $showNameAlert, content: {
                        return Alert(title: Text("下次啟動時更換"))
                    })
                
            }.navigationTitle("修改檔案")
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
                    if (data.name == "") {
                        setName = "ANONYMOUS"
                    }
                    else {
                        setName = data.name
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
}
struct userData_Previews: PreviewProvider {
    static var previews: some View {
        userData(showUserDataView: .constant(true))
            .previewLayout(.fixed(width: 844, height: 390))
    }
}
