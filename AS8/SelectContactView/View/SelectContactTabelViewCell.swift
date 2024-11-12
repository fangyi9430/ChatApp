//
//  SelectContactTabelViewCellTableViewCell.swift
//  AS8
//
//  Created by 李方一 on 11/11/24.
//

import UIKit

class SelectContactTabelViewCell: UITableViewCell {
    
    var wrapperCellView: UIView!
    var labelName: UILabel!
    var labelEmail: UILabel!
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupWrapperCellView()
        setupLabelName()
        setupLabelEmail()
        
        initConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupWrapperCellView(){
        wrapperCellView = UITableViewCell()
        
        //working with the shadows and colors...
        wrapperCellView.backgroundColor = .white
        wrapperCellView.layer.cornerRadius = 6.0
        wrapperCellView.layer.shadowColor = UIColor.gray.cgColor
        wrapperCellView.layer.shadowOffset = .zero
        wrapperCellView.layer.shadowRadius = 4.0
        wrapperCellView.layer.shadowOpacity = 0.4
        wrapperCellView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(wrapperCellView)
    }
    
    func setupLabelName(){
        labelName = UILabel()
        labelName.font = UIFont.boldSystemFont(ofSize: 14)
        labelName.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(labelName)
    }
    
    func setupLabelEmail(){
        labelEmail = UILabel()
        labelEmail.font = UIFont.boldSystemFont(ofSize: 14)
        labelEmail.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(labelEmail)
    }
    
    
    func initConstraints(){
        NSLayoutConstraint.activate([
            wrapperCellView.topAnchor.constraint(equalTo: self.topAnchor,constant: 10),
            wrapperCellView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            wrapperCellView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            wrapperCellView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            
            labelName.topAnchor.constraint(equalTo: wrapperCellView.topAnchor, constant: 10),
            labelName.leadingAnchor.constraint(equalTo: wrapperCellView.leadingAnchor, constant: 16),
            labelName.heightAnchor.constraint(equalToConstant: 10),
            labelName.widthAnchor.constraint(lessThanOrEqualTo: wrapperCellView.widthAnchor),
            
            labelEmail.bottomAnchor.constraint(equalTo: wrapperCellView.bottomAnchor, constant: 5),
            labelEmail.leadingAnchor.constraint(equalTo: labelName.leadingAnchor),
            labelEmail.heightAnchor.constraint(equalToConstant: 10),
            labelEmail.widthAnchor.constraint(lessThanOrEqualTo: labelName.widthAnchor),
          
            wrapperCellView.heightAnchor.constraint(equalToConstant: 35)
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
