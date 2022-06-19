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


struct roomData: Codable, Identifiable {
    @DocumentID var id: String?
    
    var roomID:String
    var player1ID: String
    var player2ID: String
    var player3ID: String
    var player4ID: String
    var player1Role: String
    var player2Role: String
    var player3Role: String
    var player4Role: String
    var playerNumber:String
}



struct gameLobby: View {
    @Binding var showGameLobbyView:Bool
    @State private var showUserDataView:Bool = false
    @State private var user:User?
    @State private var name = ""
    @State private var photo = ""
    @State private var roomID = ""
    @State private var inputRoomID = ""
    @State private var userID = ""
    @State private var showPhotoStickers:Bool = false
    @State private var showRoomPageView:Bool = false
    @State private var playerNumber = 0
    
    func randomRoomID() -> String {
        //隨機產生六碼房號
        var generatedNumber = ""
        for _ in 0...5 {
            let number = Int.random(in: 0...9)
            generatedNumber += String(number)
        }
        print("房號：\(generatedNumber)")
        
        roomID = generatedNumber
        
        //產生房間資料夾
        let db = Firestore.firestore()
        let data = roomData(id: "", roomID: "" , player1ID: "", player2ID: "", player3ID: "", player4ID: "", player1Role: "", player2Role: "", player3Role: "", player4Role: "", playerNumber: "")
        do {
            try db.collection("roomData").document(generatedNumber).setData(from: data)
        }catch{
            print("房間建立錯誤")
            print(error)
        }
        
        return generatedNumber
        
    }
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
                            //創一個新房間
                            let user1 = Auth.auth().currentUser
                            let db2 = Firestore.firestore()
                            let documentReference1 = db2.collection("userData").document(user1!.uid)
                            documentReference1.getDocument { document, error in
                                
                                guard let document = document,
                                      document.exists,
                                      var data1 = try? document.data(as: userProfile.self)
                                
                                else {
                                    return
                                }
                                data1.roomID = randomRoomID()
                                do {
                                    try documentReference1.setData(from: data1)
                                } catch {
                                    print(error)
                                }
                                
                                let documentReference2 = db2.collection("roomData").document(roomID)
                                documentReference2.getDocument { document, error in
                                    
                                    guard let document = document,
                                          document.exists,
                                          var data2 = try? document.data(as: roomData.self)
                                    
                                    else {
                                        return
                                    }
                                    data2.roomID = roomID
                                    playerNumber = 1
                                    data2.playerNumber = String(playerNumber)
                                    data2.player1ID = userID
                                    do {
                                        try documentReference2.setData(from: data2)
                                    } catch {
                                        print(error)
                                    }
                                    print("roomID 是 \(roomID)")
                                    
                                    showRoomPageView = true
                                }
                                
                            }
                            
                            
                        }, label: {
                            ZStack{
                                
                                RoundedRectangle(cornerRadius: 5)
                                    .foregroundColor(Color(red: 0.49, green: 0.72, blue: 0.87))
                                    .frame(width: 125, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                Text("創建房間")
                                    .font(.system(size: 30))
                                    .foregroundColor(Color(red: 0, green: 0.36, blue: 0.68))
                                    .bold()
                                
                            }
                        })
                        
                        ZStack{
                            
                            RoundedRectangle(cornerRadius: 5)
                                .foregroundColor(Color(red: 0.49, green: 0.72, blue: 0.87))
                                .frame(width: 125, height: 100, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            VStack{
                                TextField("請輸入房號", text: $inputRoomID)
                                    .frame(width: 80, height: 30, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                    .font(.system(size: 20))
                                    .foregroundColor(Color(red: 0, green: 0.36, blue: 0.68))
                                Button(action: {
                                    //加入房間
                                    playerNumber = 0
                                    let db3 = Firestore.firestore()
                                    let documentReference3 = db3.collection("roomData").document(inputRoomID)
                                    documentReference3.getDocument { document, error in
                                        
                                        guard let document = document,
                                              document.exists,
                                              let data3 = try? document.data(as: roomData.self)
                                        
                                        else {
                                            return
                                        }
                                        playerNumber = Int(data3.playerNumber)!
                                        print(playerNumber)
                                        
                                        if (playerNumber == 1){
                                            let user1 = Auth.auth().currentUser
                                            let db2 = Firestore.firestore()
                                            let documentReference1 = db2.collection("userData").document(user1!.uid)
                                            documentReference1.getDocument { document, error in
                                                
                                                guard let document = document,
                                                      document.exists,
                                                      var data1 = try? document.data(as: userProfile.self)
                                                
                                                else {
                                                    return
                                                }
                                                data1.roomID = inputRoomID
                                                do {
                                                    try documentReference1.setData(from: data1)
                                                } catch {
                                                    print(error)
                                                }
                                                
                                                let documentReference2 = db2.collection("roomData").document(inputRoomID)
                                                documentReference2.getDocument { document, error in
                                                    
                                                    guard let document = document,
                                                          document.exists,
                                                          var data2 = try? document.data(as: roomData.self)
                                                    
                                                    else {
                                                        return
                                                    }
                                                    data2.roomID = inputRoomID
                                                    playerNumber = playerNumber + 1
                                                    print("加了你後有\(playerNumber)人")
                                                    data2.playerNumber = String(playerNumber)
                                                    data2.player2ID = userID
                                                    do {
                                                        try documentReference2.setData(from: data2)
                                                    } catch {
                                                        print(error)
                                                    }
                                                    print("roomID 是 \(inputRoomID)")
                                                    roomID = inputRoomID
                                                    showRoomPageView = true
                                                }
                                                
                                            }
                                        }
                                        
                                        if (playerNumber == 2){
                                            let user1 = Auth.auth().currentUser
                                            let db2 = Firestore.firestore()
                                            let documentReference1 = db2.collection("userData").document(user1!.uid)
                                            documentReference1.getDocument { document, error in
                                                
                                                guard let document = document,
                                                      document.exists,
                                                      var data1 = try? document.data(as: userProfile.self)
                                                
                                                else {
                                                    return
                                                }
                                                data1.roomID = inputRoomID
                                                do {
                                                    try documentReference1.setData(from: data1)
                                                } catch {
                                                    print(error)
                                                }
                                                
                                                let documentReference2 = db2.collection("roomData").document(inputRoomID)
                                                documentReference2.getDocument { document, error in
                                                    
                                                    guard let document = document,
                                                          document.exists,
                                                          var data2 = try? document.data(as: roomData.self)
                                                    
                                                    else {
                                                        return
                                                    }
                                                    data2.roomID = inputRoomID
                                                    playerNumber = playerNumber + 1
                                                    print("加了你後有\(playerNumber)人")
                                                    data2.playerNumber = String(playerNumber)
                                                    data2.player3ID = userID
                                                    do {
                                                        try documentReference2.setData(from: data2)
                                                    } catch {
                                                        print(error)
                                                    }
                                                    print("roomID 是 \(inputRoomID)")
                                                    roomID = inputRoomID
                                                    showRoomPageView = true
                                                }
                                                
                                            }
                                        }
                                        if (playerNumber == 3){
                                            let user1 = Auth.auth().currentUser
                                            let db2 = Firestore.firestore()
                                            let documentReference1 = db2.collection("userData").document(user1!.uid)
                                            documentReference1.getDocument { document, error in
                                                
                                                guard let document = document,
                                                      document.exists,
                                                      var data1 = try? document.data(as: userProfile.self)
                                                
                                                else {
                                                    return
                                                }
                                                data1.roomID = inputRoomID
                                                do {
                                                    try documentReference1.setData(from: data1)
                                                } catch {
                                                    print(error)
                                                }
                                                
                                                let documentReference2 = db2.collection("roomData").document(inputRoomID)
                                                documentReference2.getDocument { document, error in
                                                    
                                                    guard let document = document,
                                                          document.exists,
                                                          var data2 = try? document.data(as: roomData.self)
                                                    
                                                    else {
                                                        return
                                                    }
                                                    data2.roomID = inputRoomID
                                                    playerNumber = playerNumber + 1
                                                    print("加了你後有\(playerNumber)人")
                                                    data2.playerNumber = String(playerNumber)
                                                    data2.player4ID = userID
                                                    do {
                                                        try documentReference2.setData(from: data2)
                                                    } catch {
                                                        print(error)
                                                    }
                                                    print("roomID 是 \(inputRoomID)")
                                                    roomID = inputRoomID
                                                    showRoomPageView = true
                                                }
                                                
                                            }
                                        }
                                    }
                                }, label: {
                                    Text("加入房間")
                                        .font(.system(size: 30))
                                        .foregroundColor(Color(red: 0, green: 0.36, blue: 0.68))
                                        .bold()
                                })
                                
                            }
                        }.fullScreenCover(isPresented: $showRoomPageView) {
                            roomPage(showRoomPageView: $showRoomPageView, roomID: $roomID)
                        }
                        Button(action: {
                            //登出
                            do {
                                //try Auth.auth().signOut()
                                showGameLobbyView = false
                            } catch {
                                print(error)
                            }
                        }, label: {
                            ZStack{
                                
                                RoundedRectangle(cornerRadius: 5)
                                    .foregroundColor(Color(red: 0.49, green: 0.72, blue: 0.87))
                                    .frame(width: 125, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                Text("退出")
                                    .font(.system(size: 30))
                                    .foregroundColor(Color(red: 0, green: 0.36, blue: 0.68))
                                    .bold()
                                
                            }
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
            let documentReference = db.collection("userData").document(user!.uid)
            userID = user!.uid
            documentReference.getDocument { document, error in
                
                guard let document = document,
                      document.exists,
                      let data = try? document.data(as: userProfile.self)
                
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
