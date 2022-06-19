//
//  register.swift
//  finalDemo
//
//  Created by User06 on 2022/5/27.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

struct userProfile: Codable, Identifiable {
    @DocumentID var id: String?
    var name: String
    var photoStickers: String
    var gender: String
    var rule: String
    var Allcard: [String]
    var healthPoint: Int
    var money: Int
    var energy: Int
    var handCard: [String]
    var usedCard: [String]
    var levels: Int
    var roomID: String
    //神器 敵人血量
}


struct register: View {
    @Binding var showRegisterView:Bool
    @State private var createAccount = ""
    @State private var createAccountPassword = ""
    @State private var confirmPassword = ""
    @State private var showAlert:Bool = false
    @State private var showMessage = ""
    var body: some View {
        VStack{
            Text("註冊")
                .font(.system(size: 25))
            HStack{
                Text("帳號")
                    .font(.system(size: 20))
                TextField("請輸入帳號", text: $createAccount)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .font(.system(size: 15))
                    .frame(width: 400)
                    .offset(x: 20)
            }
            HStack{
                Text("密碼")
                    .font(.system(size: 20))
                SecureField("請輸入密碼", text: $createAccountPassword)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .font(.system(size: 15))
                    .frame(width: 400)
                    .offset(x: 20)
            }
            HStack{
                Text("確認密碼")
                    .font(.system(size: 20))
                SecureField("再次輸入密碼", text: $confirmPassword)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .font(.system(size: 15))
                    .frame(width: 400)
            }
            Button {
                //註冊
                if (createAccountPassword == confirmPassword ){
                    Auth.auth().createUser(withEmail: createAccount, password: createAccountPassword) { result, error in
                        
                        guard let user = result?.user,
                              error == nil else {
                            showMessage = "發生錯誤"
                            return
                        }
                        
                        let db = Firestore.firestore()
                        let userID = Auth.auth().currentUser
                        let data = userProfile(name:"", photoStickers:"", gender:"",rule:"",Allcard:[""],healthPoint: 0,money: 0,energy: 0,handCard:[""],usedCard: [""],
                                               levels:0,roomID:"")
                        do {
                            try db.collection("userData").document(userID!.uid).setData(from: data)
                        }catch{
                            print(error)
                        }
                        
                        showMessage = "成功"
                    }}
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    showAlert = true
                }
                
            }label: {
                ZStack{
                    RoundedRectangle(cornerRadius: 5)
                        .frame(width: 100, height: 40)
                    Text("註冊")
                        .padding()
                        .font(.system(size: 15))
                        .foregroundColor(.white)
                }
            }.alert(isPresented: $showAlert, content: {
                return Alert(title: Text(showMessage))
            })
            HStack{
                Text("已經有帳號？")
                Button("登入"){
                    showRegisterView = false
                }
            }
        }.background(Image("slayTheSpire").scaledToFill().opacity(0.3))
    }
}

struct register_Previews: PreviewProvider {
    static var previews: some View {
        register(showRegisterView: .constant(true))
            .previewLayout(.fixed(width: 844, height: 390))
    }
}
