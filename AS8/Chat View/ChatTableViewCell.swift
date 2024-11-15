//
//  ChatTableViewCell.swift
//  AS8
//
//  Created by Eva H on 11/11/24.
//

import UIKit

class ChatTableViewCell: UITableViewCell {
    
    var wrapperCellView: UIView!
    var labelSenderName: UILabel!
    var labelMessageText: UILabel!
    var labelTime: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupWrapperCellView()
        setupLabelSenderName()
        setupLabelMessageText()
        setupLabelTime()
        
        initConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupWrapperCellView() {
        wrapperCellView = UIView() 
        wrapperCellView.backgroundColor = .white
        wrapperCellView.layer.cornerRadius = 6.0
        wrapperCellView.layer.shadowColor = UIColor.gray.cgColor
        wrapperCellView.layer.shadowOffset = .zero
        wrapperCellView.layer.shadowRadius = 4.0
        wrapperCellView.layer.shadowOpacity = 0.4
        wrapperCellView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(wrapperCellView)
    }

    
    func setupLabelSenderName() {
        labelSenderName = UILabel()
        labelSenderName.font = UIFont.boldSystemFont(ofSize: 14)
        labelSenderName.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(labelSenderName)
    }
    
    func setupLabelMessageText() {
        labelMessageText = UILabel()
        labelMessageText.font = UIFont.boldSystemFont(ofSize: 20)
        labelMessageText.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(labelMessageText)
    }
    
    func setupLabelTime() {
        labelTime = UILabel()
        labelTime.font = UIFont.boldSystemFont(ofSize: 14)
        labelTime.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(labelTime)
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            wrapperCellView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            wrapperCellView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            wrapperCellView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            wrapperCellView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),

            labelSenderName.topAnchor.constraint(equalTo: wrapperCellView.topAnchor, constant: 8),
            labelSenderName.leadingAnchor.constraint(equalTo: wrapperCellView.leadingAnchor, constant: 8),
            labelSenderName.trailingAnchor.constraint(equalTo: wrapperCellView.trailingAnchor, constant: -8),
            
            labelMessageText.topAnchor.constraint(equalTo: labelSenderName.bottomAnchor, constant: 4),
            labelMessageText.leadingAnchor.constraint(equalTo: wrapperCellView.leadingAnchor, constant: 8),
            labelMessageText.trailingAnchor.constraint(equalTo: wrapperCellView.trailingAnchor, constant: -8),
            
            labelTime.topAnchor.constraint(equalTo: labelMessageText.bottomAnchor, constant: 4),
            labelTime.leadingAnchor.constraint(equalTo: wrapperCellView.leadingAnchor, constant: 8),
            labelTime.trailingAnchor.constraint(equalTo: wrapperCellView.trailingAnchor, constant: -8),
            labelTime.bottomAnchor.constraint(equalTo: wrapperCellView.bottomAnchor, constant: -8)
        ])
    }


    
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}


