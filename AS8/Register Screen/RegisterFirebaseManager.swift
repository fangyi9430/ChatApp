//
//  RegisterFirebaseManager.swift
//  AS8
//
//  Created by Eva H on 11/10/24.
//
import UIKit
import Foundation
import FirebaseAuth

extension RegisterViewController{
    
    func registerNewAccount(){
        //MARK: display the progress indicator...
        showActivityIndicator()
        //MARK: create a Firebase user with email and password...
        if let name = registerView.textFieldName.text,
           let email = registerView.textFieldEmail.text,
           let password = registerView.textFieldPassword.text,
           let confirmedPassword = registerView.textFieldRepeatPassword.text{
            //Validations....
            
            if password == confirmedPassword {
                Auth.auth().createUser(withEmail: email, password: password, completion: {result, error in
                    if error == nil{
                        //MARK: the user creation is successful...
                        self.setNameOfTheUserInFirebaseAuth(name: name)
                    }else{
                        //MARK: there is a error creating the user...
                        self.showAlert(withMessage: "Erroring creating the user")
                    }
                })
            } else {
                self.clearPassword()
                self.hideActivityIndicator()
                self.showAlert(withMessage: "Passwords are not same")
                 
                
            }
        }
    }
    
    func clearPassword() {
        registerView.textFieldPassword.text = ""
        registerView.textFieldRepeatPassword.text = ""
    }
    
    //MARK: We set the name of the user after we create the account...
    func setNameOfTheUserInFirebaseAuth(name: String){
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.displayName = name
        changeRequest?.commitChanges(completion: {(error) in
            if error == nil{
                //MARK: the profile update is successful...
                
                //MARK: hide the progress indicator...
                self.hideActivityIndicator()
                
                //MARK: pop the current controller...
                self.navigationController?.popViewController(animated: true)
            }else{
                //MARK: there was an error updating the profile...
                print("Error occured: \(String(describing: error))")
            }
        })
    }
    
    func showAlert(withMessage message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
