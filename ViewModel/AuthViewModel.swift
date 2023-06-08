//
//  AuthViewModel.swift
//  TwitterSwiftUI
//
//  Created by MikeyW on 06/06/2022.
//

import SwiftUI
import Foundation
import FirebaseStorage
import FirebaseAuth
import Firebase


class AuthViewModel: ObservableObject {
    
    @Published var userSession: FirebaseAuth.User?
    @Published var isAuthenticating = false
    @Published var error: Error?
    @Published var user: User?
    
    static let shared = AuthViewModel()
    
    init() {
        userSession = Auth.auth().currentUser
        self.fetchUser()
    }
    
    func login(withEmail email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print("DEBUG: Failed to login: \(error.localizedDescription)")
                return
            }
            
            self.userSession = result?.user
        }
    }
    
    func registerUser(email: String, password: String, username: String, fullname: String, profileImage: UIImage) {
        
        guard let imageData = profileImage.jpegData(compressionQuality: 0.3) else { return }
        let filename = NSUUID().uuidString
        let storageRef = Storage.storage().reference().child(filename)
        
        storageRef.putData(imageData, metadata: nil) { _, error in
            if let error = error {
                print("DEBUG: Failed to upload image \(error.localizedDescription)")
                return
            }
            
            storageRef.downloadURL() { url, _ in
                guard let profileImageURL = url?.absoluteString else { return }
                
                Auth.auth().createUser(withEmail: email, password: password) { result, error in
                    if let error = error {
                        print("DEBUG: Error \(error.localizedDescription)")
                        return
                    }
                     
                    guard let user = result?.user else { return }
                    
                    let data = ["email": email, "username": username.lowercased(), "fullname": fullname, "profileImageURL": profileImageURL, "uid": user.uid]
                    
                    Firestore.firestore().collection("users").document(user.uid).setData(data) { _ in
                        self.userSession = user
                        self.fetchUser()
                    }
                    
                }
            }
        }      
    }
    
    func currentUserDoc() -> DocumentReference? {
            if let currentUser = Auth.auth().currentUser {
                return Firestore.firestore().collection("users").document(currentUser.uid)
            }
            return nil
        }
        
        func doesUserExist(completion: @escaping (Bool) -> Void) {
            guard let currentUser = Auth.auth().currentUser else { return }
            currentUserDoc()?.getDocument { snapshot, error in
                if let snapshot = snapshot, snapshot.exists && error == nil {
                    completion(true)
                } else {
                    completion(false)
                }
            }
        }
    
    func signOut() {
        userSession = nil
        user = nil
        try? Auth.auth().signOut()
    }
    
    func fetchUser() {
        guard let uid = userSession?.uid else {
            self.user = nil // Reset the user when the user session is nil
            return
        }
        
        Firestore.firestore().collection("users").document(uid).getDocument { snapshot, _ in
            guard let data = snapshot?.data() else {
                self.user = nil // Reset the user if the document doesn't exist
                return
            }
            self.user = User(dictionary: data)
        }
    }
    
    
    func tabTitle(forIndex index: Int) -> String {
        switch index {
        case 0: return "Home"
        case 1: return "Search"
        case 2: return "Messages"
        default: return ""
        }
    }
    
}
