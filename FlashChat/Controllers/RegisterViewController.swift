//
//  RegisterViewController.swift
//  FlashChat
//
//  Created by Марк Райтман on 17.03.2023.
//

import Foundation
import UIKit
import FirebaseAuth

class RegisterViewController: UIViewController {

    //MARK: - Textfields
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    //MARK: - Buttons
    @IBAction func registerPressed(_ sender: UIButton) {
        
        // Проверяем, что email и password есть в текстовых полях ввода пользователей
        if let email = emailTextfield.text, let password = passwordTextfield.text {
            
            // Используем метод createUser для создания нового пользователя в Firebase
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                
                // Если произошла ошибка при создании пользователя, показываем пользователю оповещение об ошибке
                if let e = error {
                    
                    // Показываем оповещение об ошибке с сообщением описания ошибки
                    let alertController = UIAlertController(title: "Error", message: e.localizedDescription, preferredStyle: .alert)
                    
                    // Добавляем кнопку "Ок" для закрытия сообщения об ошибке
                    let alertAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
                    alertController.addAction(alertAction)
                    
                    // Показываем сообщение об ошибке на экране
                    self.present(alertController, animated: true, completion: nil)
                } else {
                    // Если пользователь успешно создан, переходим на следующий экран
                    self.performSegue(withIdentifier: "RegisterToChat", sender: self)
                }
            }
            
        }
    }
    
}
