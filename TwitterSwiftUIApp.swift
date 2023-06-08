//
//  TwitterSwiftUIApp.swift
//  TwitterSwiftUI
//
//  Created by MikeyW on 27/04/2022.
//

import SwiftUI
import Firebase

@main
struct TwitterSwiftUIApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(AuthViewModel.shared)
//            LoginView().environmentObject(AuthViewModel.shared)
        }
    }
}
