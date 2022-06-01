//
//  profilePhoto.swift
//  finalDemo
//
//  Created by User06 on 2022/5/28.
//

import SwiftUI

struct profilePhoto: View {
    let face: String
    let bodyMaterial: String
    let head: String
    var body: some View {
        ZStack{
            Image(bodyMaterial)
                .resizable()
                .frame(width: 409/2, height: 366/2)
                .scaledToFill()
                .offset(x: -30, y:  70)
            Image(head)
                .resizable()
                .frame(width: 236/2, height: 283/2)
                .scaledToFill()
                .offset(x: -7, y:  -68)
            Image(face)
                .resizable()
                .frame(width: 149/2, height: 146.5/2)
                .scaledToFill()
                .offset(x: 6, y:  -55)
        }
    }
}

struct profilePhoto_Previews: PreviewProvider {
    static var previews: some View {
        profilePhoto(face: "face29", bodyMaterial:"body8", head:"head19")
    }
}
