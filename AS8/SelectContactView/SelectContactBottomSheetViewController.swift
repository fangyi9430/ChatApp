//
//  SelectContactViewController.swift
//  AS8
//
//  Created by 李方一 on 11/11/24.
//

import UIKit
import FirebaseAuth

class SelectContactBottomSheetViewController: UIViewController {
    
    let selectContactScreen = SelectContactBottonSheetView()
    
    var contactsList = [Contact]()
    
    private var isExpanded = true
    
    override func loadView() {
            view = selectContactScreen
        }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "start chatting!"
        
        setupBottomSheet()
        
        selectContactScreen.selectContactsTabelView.delegate = self
        selectContactScreen.selectContactsTabelView.dataSource = self
        
        selectContactScreen.selectContactsTabelView.separatorStyle = .none
        
        fetchContactsFromFirebase()
        
        // notification center to hear if a contact selected.
        // this notification is for main screen to update and for chatting screen
        NotificationCenter.default.addObserver(self, selector: #selector(didReceiveContactSelection(_:)), name: .contactSelected, object: nil)
        
        // this really mean something when finish constraints.
        selectContactScreen.selectContactsTabelView.reloadData()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func navigateToChatView(chatID: String, contact: Contact) {
        print("pretend we jump to chatting screen.")
        /*let chatViewController = ChatViewController()
        chatViewController.chatID = chatID
        chatViewController.contact = contact
        navigationController?.pushViewController(chatViewController, animated: true)*/
    }
    
    private func setupBottomSheet() {
        if let sheetPresentationController = self.sheetPresentationController {
            sheetPresentationController.detents = [.medium(), .large()]
            sheetPresentationController.prefersGrabberVisible = true
            sheetPresentationController.prefersScrollingExpandsWhenScrolledToEdge = false
        }
    }
    
    @objc func didReceiveContactSelection(_ notification: Notification) {
        // get email for current user and selected user
        guard let contact = notification.userInfo?["contact"] as? Contact,
              let currentUserEmail = Auth.auth().currentUser?.email else { return }
        // generate chat id
        let chatID = generateChatID(for: currentUserEmail, and: contact.email)
        // call function to update users db
        updateChatID(currentUserEmail: currentUserEmail, selectedContactEmail: contact.email, chatID: chatID) { success, error in
            if success {
                print("Users chats updated successfully")
            } else if let error = error {
                print("Error updating users chats: \(error)")
            }
        }
        
        // call function to update Chats db
        createChatDocument(chatID: chatID) { success, error in
            if success {
                print("Chat document created successfully")
                self.navigateToChatView(chatID: chatID, contact: contact)
            } else if let error = error {
                print("Error creating chat document: \(error)")
            }
        }
        
        
    }
    
    func generateChatID(for user1: String, and user2: String) -> String {
        // email1 + email2 as id for a chat， sorted to avoid a + b and b + a as same
        let sortedEmails = [user1, user2].sorted()
        return "\(sortedEmails[0])_\(sortedEmails[1])"
    }


}
