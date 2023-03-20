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
        
        tableView.dataSource = self
        navigationBarSetup()
        
        tableView.register(UINib(nibName: Cells.cellNibName, bundle: nil), forCellReuseIdentifier: Cells.cellIdentifier)
    }
    
    //MARK: - Properties
    var messages: [Message] = [
        Message(sender: "1@2.com", body: "Hello!"),
        Message(sender: "a@b.com", body: "Hi!"),
        Message(sender: "1@2.com", body: "Indicates an error occurred when accessing the keychain. The `NSLocalizedFailureReasonErrorKey` field in the `userInfo` dictionary will contain more information about the error encountered.!"),
        Message(sender: "a@b.com", body: "You use text fields to gather text-based input from the user using the onscreen keyboard. The keyboard is configurable for many different types of input such as plain text, emails, numbers, and so on. Text fields use the target-action mechanism and a delegate object to report changes made during the course of editing.!"),
        Message(sender: "1@2.com", body: "If the view controller or one of its ancestors is a child of a navigation controller, this property contains the owning navigation controller. This property is nil if the view controller is not embedded inside a navigation controller.")
    ]
    
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
        title = AppName.appName
    }
    
}

//MARK: - Extensions
extension ChatViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.cellIdentifier, for: indexPath) as! MessageCell
        cell.label.text = messages[indexPath.row].body
        
        return cell
    }
    
    
}
