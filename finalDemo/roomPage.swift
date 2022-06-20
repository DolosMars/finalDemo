//
//  roomPage.swift
//  finalDemo
//
//  Created by User06 on 2022/6/19.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift
import NukeUI


struct roomPage: View {
    
    
    @Binding var showRoomPageView:Bool
    @Binding var roomID:String
    @State private var player1SelectRole = 1
    @State private var player2SelectRole = 1
    @State private var player3SelectRole = 1
    @State private var player4SelectRole = 1
    
    @State private var player1ID = ""
    @State private var player1Name = " "
    @State private var player1photo = "person.crop.circle.fill"
    @State private var showPlayer1PhotoStickers = false
    
    @State private var player2ID = ""
    @State private var player2Name = " "
    @State private var player2photo = "person.crop.circle.fill"
    @State private var showPlayer2PhotoStickers = false
    
    @State private var player3ID = ""
    @State private var player3Name = " "
    @State private var player3photo = "person.crop.circle.fill"
    @State private var showPlayer3PhotoStickers = false
    
    @State private var player4ID = ""
    @State private var player4Name = " "
    @State private var player4photo = "person.crop.circle.fill"
    @State private var showPlayer4PhotoStickers = false
    
    @State private var playerNumber = 0
    
    var body: some View {
        VStack{
            Text("房間號碼\(roomID)")
            HStack{
                //玩家一
                VStack{
                    
                    if showPlayer1PhotoStickers{
                        LazyImage(source:player1photo)
                            //.resizable()
                            //.scaledToFill()
                            .frame(width: 100, height: 100)
                            .padding()
                        
                    }else{
                        Image(systemName: player1photo)
                            .resizable()
                            //.scaledToFill()
                            .frame(width: 100, height: 100)
                            .padding()
                    }
                    Text(player1Name)
                        .font(.system(size: 20))
                        .foregroundColor(Color(red: 0, green: 0.36, blue: 0.68))
                        .bold()
                    
                    Picker(selection: $player1SelectRole, label: Text("選擇角色")) {
                        Text("鐵衛士").tag(1)
                        Text("寂靜獵手").tag(2)
                        Text("故障機器人").tag(1)
                        Text("觀者").tag(2)
                    }.frame(width: 100, height: 100, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .clipped()
                    Spacer()
                        .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    /*Button(action: {
                        //準備跳到遊戲畫面
                    }, label: {
                        Text("準備")
                    })*/
                }
                
                //玩家二
                VStack{
                    if showPlayer2PhotoStickers{
                        LazyImage(source:player2photo)
                            //.resizable()
                            //.scaledToFill()
                            .frame(width: 100, height: 100)
                            .padding()
                        
                    }else{
                        Image(systemName: player2photo)
                            .resizable()
                            //.scaledToFill()
                            .frame(width: 100, height: 100)
                            .padding()
                    }
                    Text(player2Name)
                        .font(.system(size: 20))
                        .foregroundColor(Color(red: 0, green: 0.36, blue: 0.68))
                        .bold()
                    
                    Picker(selection: $player2SelectRole, label: Text("選擇角色")) {
                        Text("鐵衛士").tag(1)
                        Text("寂靜獵手").tag(2)
                        Text("故障機器人").tag(1)
                        Text("觀者").tag(2)
                    }.frame(width: 100, height: 100, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .clipped()
                    Spacer()
                        .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    /*Button(action: {
                        //準備跳到遊戲畫面
                    }, label: {
                        Text("準備")
                    })*/
                }
                
                //玩家三
                VStack{
                    if showPlayer3PhotoStickers{
                        LazyImage(source:player3photo)
                            //.resizable()
                            //.scaledToFill()
                            .frame(width: 100, height: 100)
                            .padding()
                        
                    }else{
                        Image(systemName: player3photo)
                            .resizable()
                            //.scaledToFill()
                            .frame(width: 100, height: 100)
                            .padding()
                    }
                    Text(player3Name)
                        .font(.system(size: 20))
                        .foregroundColor(Color(red: 0, green: 0.36, blue: 0.68))
                        .bold()
                    Picker(selection: $player3SelectRole, label: Text("選擇角色")) {
                        Text("鐵衛士").tag(1)
                        Text("寂靜獵手").tag(2)
                        Text("故障機器人").tag(1)
                        Text("觀者").tag(2)
                    }.frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .clipped()
                    Spacer()
                        .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    
                    /*Button(action: {
                        //準備跳到遊戲畫面
                    }, label: {
                        Text("準備")
                    })*/
                }
                //玩家四
                VStack{
                    if showPlayer4PhotoStickers{
                        LazyImage(source:player4photo)
                            //.resizable()
                            //.scaledToFill()
                            .frame(width: 100, height: 100)
                            .padding()
                        
                    }else{
                        Image(systemName: player4photo)
                            .resizable()
                            //.scaledToFill()
                            .frame(width: 100, height: 100)
                            .padding()
                    }
                    Text(player4Name)
                        .font(.system(size: 20))
                        .foregroundColor(Color(red: 0, green: 0.36, blue: 0.68))
                        .bold()
                    Picker(selection: $player4SelectRole, label: Text("選擇角色")) {
                        Text("鐵衛士").tag(1)
                        Text("寂靜獵手").tag(2)
                        Text("故障機器人").tag(1)
                        Text("觀者").tag(2)
                    }.frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .clipped()
                    Spacer()
                        .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    /*Button(action: {
                        //準備跳到遊戲畫面
                    }, label: {
                        Text("準備")
                    })*/
                }
                
            }.onAppear{
                print(roomID)
                let db = Firestore.firestore()
                db.collection("roomData").addSnapshotListener{_,_ in
                let documentReference = db.collection("roomData").document(roomID)

                documentReference.getDocument { document, error in
                    
                    guard let document = document,
                          document.exists,
                          let data = try? document.data(as: roomData.self)
                    
                    else {
                        return
                    }
                    playerNumber = Int(data.playerNumber)!
                    player1ID = data.player1ID
                    player2ID = data.player2ID
                    player3ID = data.player3ID
                    player4ID = data.player4ID
                    
                    if (player1ID != ""){
                        let documentReference2 = db.collection("userData").document(data.player1ID)

                        documentReference2.getDocument { document, error in
                            
                            guard let document = document,
                                  document.exists,
                                  let data = try? document.data(as: userProfile.self)
                            
                            else {
                                return
                            }
                            player1photo = data.photoStickers
                            player1Name = data.name
                            showPlayer1PhotoStickers = true
                        }
                    }
                    
                    if (player2ID != ""){
                        let documentReference2 = db.collection("userData").document(data.player2ID)

                        documentReference2.getDocument { document, error in
                            
                            guard let document = document,
                                  document.exists,
                                  let data = try? document.data(as: userProfile.self)
                            
                            else {
                                return
                            }
                            player2photo = data.photoStickers
                            player2Name = data.name
                            showPlayer2PhotoStickers = true
                        }
                    }

                    if (player3ID != ""){
                        let documentReference2 = db.collection("userData").document(data.player3ID)

                        documentReference2.getDocument { document, error in
                            
                            guard let document = document,
                                  document.exists,
                                  let data = try? document.data(as: userProfile.self)
                            
                            else {
                                return
                            }
                            player3photo = data.photoStickers
                            player3Name = data.name
                            showPlayer3PhotoStickers = true
                        }
                    }
                    
                    if (player4ID != ""){
                        let documentReference2 = db.collection("userData").document(data.player4ID)

                        documentReference2.getDocument { document, error in
                            
                            guard let document = document,
                                  document.exists,
                                  let data = try? document.data(as: userProfile.self)
                            
                            else {
                                return
                            }
                            player4photo = data.photoStickers
                            player4Name = data.name
                            showPlayer3PhotoStickers = true
                        }
                    }
                }

                }
                /*for index in 0...5 {
                    
                }*/
            }
        
            Button(action: {
                print("room現在有\(playerNumber) gogo")
            }, label: {
                Text("出發")
                
            })
            
        Button(action: {
            showRoomPageView = false
            //人都能進來
            let db = Firestore.firestore()
            let documentReference = db.collection("roomData").document(roomID)

            documentReference.getDocument { document, error in
                
                guard let document = document,
                      document.exists,
                      var data = try? document.data(as: roomData.self)
                
                else {
                    return
                }
                
                var personNumber = Int(data.playerNumber)
                data.playerNumber = String(personNumber!-1)
                do {
                    try documentReference.setData(from: data)
                } catch {
                    print(error)
                }
                
            }
        }, label: {
            Text("退出此房間")
        })
        }
        }}


struct roomPage_Previews: PreviewProvider {
    static var previews: some View {
        roomPage(showRoomPageView: .constant(true),roomID: .constant("000000"))
            .previewLayout(.fixed(width: 844, height: 390))
    }
}
