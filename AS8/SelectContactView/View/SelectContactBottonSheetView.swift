//
//  SelectContactView.swift
//  AS8
//
//  Created by 李方一 on 11/11/24.
//

import UIKit

class SelectContactBottonSheetView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    var startNewChatLabel:UILabel!
    var selectContactsTabelView: UITableView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        setupStartNewChatLabel()
        setupSelectContactsTabelView()
        
        initConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupSelectContactsTabelView(){
        selectContactsTabelView = UITableView()
        selectContactsTabelView.register(ContactsTableViewCell.self, forCellReuseIdentifier: Configs.tableViewContactsID)
        selectContactsTabelView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(selectContactsTabelView)
    }
    
    func setupStartNewChatLabel(){
        startNewChatLabel = UILabel()
        startNewChatLabel.text = "select a contact to start chatting:"
        startNewChatLabel.font = UIFont.systemFont(ofSize: 15)
        startNewChatLabel.textColor = .black
        startNewChatLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(startNewChatLabel)
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            
            startNewChatLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 8),
            startNewChatLabel.heightAnchor.constraint(equalToConstant: 20),
            startNewChatLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            startNewChatLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: 8),
            
            selectContactsTabelView.topAnchor.constraint(equalTo: startNewChatLabel.bottomAnchor, constant: 8),
            selectContactsTabelView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -8),
            selectContactsTabelView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            selectContactsTabelView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16)
            
        ])
    }

}
