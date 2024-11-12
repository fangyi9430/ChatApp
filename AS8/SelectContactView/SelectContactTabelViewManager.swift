//
//  SelectContactTabelViewManager.swift
//  AS8
//
//  Created by 李方一 on 11/12/24.
//

import Foundation
import UIKit

extension SelectContactBottomSheetViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Configs.tableViewContactsID, for: indexPath) as! ContactsTableViewCell
        cell.labelName.text = contactsList[indexPath.row].name
        cell.labelEmail.text = contactsList[indexPath.row].email
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let selectedContact = contactsList[indexPath.row]
            // sent notification. this is for selectcontact screen.
            NotificationCenter.default.post(name: .contactSelected, object: nil, userInfo: ["contact": selectedContact])
        }
}
