//
//  ContentView.swift
//  finalDemo
//
//  Created by User06 on 2022/5/4.
//

import SwiftUI
import FirebaseAuth


struct ContentView: View {
    @State private var showRegisterView:Bool = false
    @State private var showGameLobbyView:Bool = false
    @State private var createAccount = ""
    @State private var createAccountPassword = ""
    
    var textFieldBorder: some View {
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.blue, lineWidth: 5)
    }
    
    var body: some View {
        
        VStack{
            Text("登入")
                .font(.system(size: 25))
            HStack{
                Text("帳號")
                    .font(.system(size: 20))
                TextField("請輸入帳號", text: $createAccount)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .font(.system(size: 15))
                    .frame(width: 400)
            }
            HStack{
                Text("密碼")
                    .font(.system(size: 20))
                SecureField("請輸入密碼", text: $createAccountPassword)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .font(.system(size: 15))
                    .frame(width: 400)
            }
            Button {
                //登入
                Auth.auth().signIn(withEmail: createAccount, password: createAccountPassword) { result, error in
                     guard error == nil else {
                        print(error?.localizedDescription)
                        return
                     }
                }
                showGameLobbyView = true
            }label: {
                ZStack{
                    RoundedRectangle(cornerRadius: 5)
                        .frame(width: 100, height: 40)
                    Text("登入")
                        .padding()
                        .font(.system(size: 15))
                        .foregroundColor(.white)
                    
                
                }
            }.fullScreenCover(isPresented: $showGameLobbyView) {
                gameLobby( showGameLobbyView: $showGameLobbyView)
            }
            HStack{
                Text("還沒有帳號？")
                Button("註冊"){
                    showRegisterView = true
                }.fullScreenCover(isPresented: $showRegisterView) {
                    register( showRegisterView: $showRegisterView)
                }
            }
            
        }.background(Image("slayTheSpire").scaledToFill().opacity(0.3))
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewLayout(.fixed(width: 844, height: 390))
    }
}

