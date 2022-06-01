//
//  finalDemoApp.swift
//  finalDemo
//
//  Created by User06 on 2022/5/4.
//

import SwiftUI
import Firebase

@main
struct finalDemoApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
