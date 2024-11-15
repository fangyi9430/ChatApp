//
//  ChatViewController.swift
//  AS8
//
//  Created by Eva H on 11/10/24.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class ChatViewController: UIViewController {
    var currentUser:FirebaseAuth.User?
    
    let chatView = ChatView()
    
    let database = Firestore.firestore()
    
    var messages: [Message] = []
     
    
    override func loadView() {
        view = chatView
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK: patching table view delegate and data source...
        chatView.tableViewMessages.delegate = self
        chatView.tableViewMessages.dataSource = self
        
        //MARK: removing the separator line...
        chatView.tableViewMessages.separatorStyle = .none
        
        chatView.tableViewMessages.rowHeight = UITableView.automaticDimension
        chatView.tableViewMessages.estimatedRowHeight = 100 
    
        title = "Test2" //currentUser.name 后面替换

        chatView.buttonSend.addTarget(self, action: #selector(onSendButtonTapped), for: .touchUpInside)
        
        getMessageList()
    }
    
    @objc func onSendButtonTapped(){
        
        if let messageText = chatView.textFieldMessage.text, !messageText.isEmpty {
           let name = "test" //替换成 sender
            let date = Date()
            
            let message = Message(dateTime: date, name: name, text: messageText)
            
            print(message)
            
            let collectionMessage = database
                .collection("chats")
                .document("chat1") //换成notification里的chat number
                .collection("message")
            
            
            do{
                try collectionMessage.addDocument(from: message, completion: {(error) in
                    if error == nil{
//                        self.getMessageList()
//                        self.clearInputText()
                        self.messages.append(message)
                        self.chatView.tableViewMessages.reloadData()
                        self.clearInputText()
                    }
                })
            }catch{
                print("Error adding document!")
            }
            
        } else {
            // Call the alert function with a custom message
            showAlert(withMessage: "Message is empty. Please enter a message before sending.")
        }
    }
    
    
    func getMessageList() {
        let collectionMessage = database
            .collection("chats")
            .document("chat1") //换成notification里的chat number
            .collection("message")
        
        collectionMessage.getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
            } else {
                // Clear the messages array before adding new data
                self.messages = []
                
                for document in querySnapshot!.documents {
                    if let message = try? document.data(as: Message.self) {
                        self.messages.append(message)
                    }
                }
                //reverse the order
                self.messages.reverse()
                
                // After fetching all messages, you can print or use them
                print("Fetched Messages: \(self.messages)")
                
                // Optional: Reload a table view if you’re displaying the messages
                self.chatView.tableViewMessages.reloadData()
            }
        }
    }
    
    // functional function
    func clearInputText() {
        chatView.textFieldMessage.text = ""
    }
    
    func showAlert(withMessage message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    

}

extension ChatViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Configs.tableViewChatID, for: indexPath) as! ChatTableViewCell
        
        cell.labelSenderName.text = messages[indexPath.row].name
        cell.labelMessageText.text = messages[indexPath.row].text
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        cell.labelTime.text = dateFormatter.string(from: messages[indexPath.row].dateTime)
        
        return cell
    }
}
