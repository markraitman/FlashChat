//
//  LoginViewController.swift
//  FlashChat
//
//  Created by Марк Райтман on 17.03.2023.
//

import Foundation
import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        backButonColor()
    }
    
    //MARK: - Outlets
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    //MARK: - Actions (Login)
    @IBAction func loginPressed(_ sender: UIButton) {
        // Сначала мы извлекаем значения электронной почты и пароля из текстовых полей, только если они не nil.
        if let email = emailTextfield.text, let password = passwordTextfield.text {
            
            // Затем мы используем опциональную связку для идентификации пользователя с использованием введенных учетных данных.
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                
                // Если ошибка есть, то мы можем показать сообщение об ошибке.
                if let e = error {
                    let alertController = UIAlertController(title: "Error", message: e.localizedDescription, preferredStyle: .alert)
                    let alertAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
                    alertController.addAction(alertAction)
                    self.present(alertController, animated: true, completion: nil)
                } else {
                    // Если ошибки нет, то мы выполняем переход на следующий экран через performSegue.
                    self.performSegue(withIdentifier: Segues.loginSegue, sender: self)
                }
            }
        }
        
    }
    
    //MARK: - Methods
    func backButonColor() {
        navigationController?.navigationBar.tintColor = UIColor.white
    }
    
}
