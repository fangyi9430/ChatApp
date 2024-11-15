//
//  data.swift
//  AS8
//
//  Created by Eva H on 11/10/24.
//

import Foundation

struct Message: Codable {
    var dateTime: Date
    var name: String
    var text: String
    
    init(dateTime: Date, name: String, text: String) {
        self.dateTime = dateTime
        self.name = name
        self.text = text
    }
}

//struct MessageList: Codable {
//    var MessageList: [Message]
//    init(MessageList: [Message]) {
//        self.MessageList = MessageList
//    }
//}

