//
//  ChatView.swift
//  AS8
//
//  Created by Eva H on 11/10/24.
//

import UIKit

class ChatView: UIView {
    
    var labelTitle: UILabel! // texting的对象
    var textFieldMessage: UITextField!
    var buttonSend: UIButton!
    var tableViewMessages: UITableView!

    override init(frame: CGRect){
        super.init(frame: frame)
        self.backgroundColor = .white
        
        // Uncomment if you want to set up the title label
        // setupLabelTitle()
        setupTextFieldMessage()
        setupSendButton()
        setupTableViewMessages()
        
        initConstraints()
    }
    
    func setupTableViewMessages() {
        tableViewMessages = UITableView()
        tableViewMessages.register(ChatTableViewCell.self, forCellReuseIdentifier: Configs.tableViewChatID)
        tableViewMessages.translatesAutoresizingMaskIntoConstraints = false
        
        tableViewMessages.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        
        self.addSubview(tableViewMessages)
    }
    
    func setupTextFieldMessage() {
        textFieldMessage = UITextField()
        textFieldMessage.placeholder = "New Message"
        textFieldMessage.borderStyle = .roundedRect
        textFieldMessage.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(textFieldMessage)
    }
    
    func setupSendButton() {
        buttonSend = UIButton(type: .system)
        buttonSend.setTitle("Send", for: .normal)
        buttonSend.titleLabel?.font = .boldSystemFont(ofSize: 16)
        buttonSend.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(buttonSend)
    }
    
    func initConstraints(){
        NSLayoutConstraint.activate([
            tableViewMessages.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 16),
            tableViewMessages.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            tableViewMessages.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            tableViewMessages.bottomAnchor.constraint(equalTo: textFieldMessage.topAnchor, constant: -8),
            
            
            textFieldMessage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            textFieldMessage.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            textFieldMessage.trailingAnchor.constraint(equalTo: buttonSend.leadingAnchor, constant: -8),
            
            buttonSend.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            buttonSend.bottomAnchor.constraint(equalTo: textFieldMessage.bottomAnchor),
            buttonSend.widthAnchor.constraint(equalToConstant: 60),
            
            
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
