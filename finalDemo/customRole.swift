//
//  customRole.swift
//  finalDemo
//
//  Created by User06 on 2022/5/28.
//

import SwiftUI
import FirebaseAuth
import FirebaseStorage
import FirebaseStorageSwift
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

struct customRole: View {
    @Binding var showCustomRoleView:Bool
    @State private var start = 0
    @State private var showPicture = "head"
    @State private var pickHead = 5
    @State private var pickBody = 6
    @State private var pickFace = 6
    @State private var uiImage: UIImage?
    @State private var showPictureAlert:Bool = false
    
    func uploadPhoto(image: UIImage, completion: @escaping (Result<URL, Error>) -> Void) {
        
        let fileReference = Storage.storage().reference().child(UUID().uuidString + ".jpg")
        if let data = image.jpegData(compressionQuality: 0.9) {
            
            fileReference.putData(data, metadata: nil) { result in
                switch result {
                case .success(_):
                    fileReference.downloadURL(completion: completion)
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
    
    /*func setUserPhoto(url: URL) {
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.photoURL = url
        changeRequest?.commitChanges(completion: { error in
            guard error == nil else {
                print(error?.localizedDescription)
                return
            }
        })
    }*/
    
    var body: some View {
        HStack{
            VStack{
                /*ZStack{
                 Image("body\(pickBody)")
                 .resizable()
                 .frame(width: 409/2, height: 366/2)
                 .scaledToFill()
                 .offset(x: -30, y:  70)
                 Image("head\(pickHead)")
                 .resizable()
                 .frame(width: 236/2, height: 283/2)
                 .scaledToFill()
                 .offset(x: -7, y:  -68)
                 Image("face\(pickFace)")
                 .resizable()
                 .frame(width: 149/2, height: 146.5/2)
                 .scaledToFill()
                 .offset(x: 6, y:  -55)
                 }*/
                profilePhoto(face: "face\(pickFace)", bodyMaterial:"body\(pickBody)", head:"head\(pickHead)")
                HStack{
                    Button(action: {
                        showCustomRoleView = false
                    }, label: {
                        Text("返回")
                    })
                    Button(action: {
                        pickFace = Int.random(in: 0..<30)
                        pickHead = Int.random(in: 0..<46)
                        pickBody = Int.random(in: 0..<30)
                    }, label: {
                        Text("隨機")
                    })
                    Button(action: {
                        //生成圖片
                        var photoStickerURL = ""
                        uiImage = profilePhoto(face: "face\(pickFace)", bodyMaterial:"body\(pickBody)", head:"head\(pickHead)").snapshot()
                        uploadPhoto(image: uiImage!) { result in
                            switch result {
                            case .success(let url): do {
                                //setUserPhoto(url: url)
                                //print("圖片位址\(url)")
                                photoStickerURL = url.absoluteString
                                print("url\(photoStickerURL)")
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
                                    data.photoStickers = photoStickerURL
                                    do {
                                        try documentReference.setData(from: data)
                                    } catch {
                                        print(error)
                                    }
                                    
                                }
                            }
                            case .failure(let error):
                                print(error)
                                
                            }
                        }
                        showPictureAlert = true
                    }, label: {
                        Text("確定")
                    }).alert(isPresented: $showPictureAlert, content: {
                        return Alert(title: Text("下次啟動時更換"))
                    })
                }.offset(x: -20, y: 55)
            }
            VStack{
                ForEach(0..<3){i in
                    HStack{
                        ForEach(0..<5){ j in
                            
                            Button(action:{
                                if (showPicture == "head"){
                                    pickHead = start+i*5+j
                                }else if (showPicture == "face"){
                                    pickFace = start+i*5+j
                                }else if (showPicture == "body"){
                                    pickBody = start+i*5+j
                                }
                            } , label: {
                                Image("\(showPicture)\(start+i*5+j)")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 60, height: 60)
                            })
                        }}}
                
                HStack{
                    Button(action:{
                        if (start-15 >= 0)
                        {
                            start -= 15
                        }
                    } , label: {
                        Text("上一頁")
                    })
                    Spacer()
                        .frame(width: 250, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    Button(action:{
                        if (showPicture == "head")
                        {
                            if (start+15<=30){
                                start += 15
                            }
                        }
                        else{
                            
                            if (start+15<=15){
                                start += 15
                            }
                        }
                    } , label: {
                        Text("下一頁")
                    })
                }
                Divider()
                    .frame(width: 400, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                HStack{
                    //五個button
                    Button(action:{
                        start = 0
                        showPicture = "head"
                    } , label: {
                        Image("head0")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 60, height: 60)
                    })
                    
                    Button(action:{
                        start = 0
                        showPicture = "face"
                    } , label: {
                        Image("face0")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 60, height: 60)
                    })
                    
                    Button(action:{
                        start = 0
                        showPicture = "body"
                    } , label: {
                        Image("body0")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 60, height: 60)
                    })
                    
                    //調不好 心態崩了 不想弄了
                    /*Button(action:{
                     showPicture = "accessories"
                     } , label: {
                     Image("accessories2")
                     .resizable()
                     .scaledToFill()
                     .frame(width: 60, height: 20)
                     })
                     
                     Button(action:{
                     showPicture = "facial"
                     } , label: {
                     Image("facial6")
                     .resizable()
                     .scaledToFill()
                     .frame(width: 60, height: 60)
                     .offset(x: -15, y: 15)
                     })*/
                    
                }
            }
        }
    }
}

struct customRole_Previews: PreviewProvider {
    static var previews: some View {
        customRole(showCustomRoleView: .constant(true))
            .previewLayout(.fixed(width: 844, height: 390))
    }
}
