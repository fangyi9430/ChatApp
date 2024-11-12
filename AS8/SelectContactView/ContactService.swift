//
//  ContactService.swift
//  AS8
//  this file is for working with backend.
//  Created by 李方一 on 11/12/24.
//

import Foundation
import FirebaseFirestore

extension SelectContactBottomSheetViewController {
    
    
    func fetchContactsFromFirebase() {
        let database = Firestore.firestore()
        
        database.collection("users")
            .getDocuments { [weak self] (snapshot, error) in
                guard let self = self else { return }
                
                if let error = error {
                    print("Error fetching contacts: \(error)")
                    return
                }
                
                guard let snapshot = snapshot else {
                    print("No snapshot found")
                    return
                }
                
                print("Fetched \(snapshot.documents.count) documents")
                
        
                self.contactsList = snapshot.documents.compactMap { document in
                    
                    guard let name = document.get("name") as? String,
                          let email = document.get("email") as? String else {
                        return nil
                    }
                    return Contact(name: name, email: email, phone: 0)
                }
                
               
                self.contactsList.sort(by: { $0.name < $1.name })
             
                DispatchQueue.main.async {
                    self.selectContactScreen.selectContactsTabelView.reloadData()
                }
            }
    }
    
    // update chatid in users
    func updateChatID(currentUserEmail: String, selectedContactEmail: String, chatID: String, completion: @escaping (Bool, Error?) -> Void) {
        
        let database = Firestore.firestore()
        
        let usersRef = database.collection("users")
                
        // Step 1: update current user's chats
        let currentUserQuery = usersRef.whereField("email", isEqualTo: currentUserEmail)
                
        currentUserQuery.getDocuments { (snapshot, error) in
            if let error = error {
                completion(false, error)
                return
            }
            
            guard let document = snapshot?.documents.first else {
                completion(false, NSError(domain: "ContactService", code: -1, userInfo: [NSLocalizedDescriptionKey: "Current user not found"]))
                return
            }
            
            let currentUserRef = document.reference
            currentUserRef.updateData([
                "chats.chat_with_\(selectedContactEmail)": ["chat_id": chatID]
            ]) { error in
                if let error = error {
                    completion(false, error)
                } else {
                    completion(true, nil) // 当前用户的 chats 字段更新成功
                }
            }
        }
                
        // Step 2: update selected contact's chats
        let selectedUserQuery = usersRef.whereField("email", isEqualTo: selectedContactEmail)
        
        selectedUserQuery.getDocuments { (snapshot, error) in
            if let error = error {
                completion(false, error)
                return
            }
            
            guard let selectedUserDocument = snapshot?.documents.first else {
                completion(false, NSError(domain: "ContactService", code: -2, userInfo: [NSLocalizedDescriptionKey: "Selected contact not found"]))
                return
            }
            
            let selectedUserRef = selectedUserDocument.reference
            selectedUserRef.updateData([
                "chats.chat_with_\(currentUserEmail)": ["chat_id": chatID]
            ]) { error in
                if let error = error {
                    completion(false, error)
                } else {
                    completion(true, nil)
                }
            }
        }
    }
    
    // update Chats doc.
    func createChatDocument(chatID: String, completion: @escaping (Bool, Error?) -> Void) {
        
        let database = Firestore.firestore()
        
        let chatRef = database.collection("chats").document(chatID)
        
        // create new chat doc and initialize message as empty list.
        chatRef.setData([
            "messages": []
        ]) { error in
            if let error = error {
                completion(false, error)
            } else {
                completion(true, nil)
            }
        }
    }
            
    

}
