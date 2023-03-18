//
//  ChatViewController.swift
//  FlashChat
//
//  Created by Марк Райтман on 17.03.2023.
//

import Foundation
import UIKit
import FirebaseAuth

class ChatViewController: UIViewController {
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBarSetup()
    }
    
    //MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextfield: UITextField!
    
    
    //MARK: - Actions
    @IBAction func sendPressed(_ sender: UIButton) {
    }
    
    @IBAction func logOutPressed(_ sender: UIBarButtonItem) {
        do {
            // Выход из учетной записи пользователя
            try Auth.auth().signOut()
            
            // Возвращение на начальный экран
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
            // Если возникает ошибка при выходе, выводим сообщение об ошибке
            print("Ошибка выхода из учетной записи: %@", signOutError)
        }
    }
    
    //MARK: - Methods
    func navigationBarSetup() {
        navigationController?.navigationBar.tintColor = UIColor.black
        navigationController?.navigationItem.hidesBackButton = true
        title = "⚡️FlashChat"
    }
    
}
