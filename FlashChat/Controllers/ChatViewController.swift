//
//  ChatViewController.swift
//  FlashChat
//
//  Created by Марк Райтман on 17.03.2023.
//

import Foundation
import UIKit
import FirebaseAuth
import FirebaseFirestore
// Импортируем NotificationCenter
import NotificationCenter

class ChatViewController: UIViewController {
    
    //MARK: - Properties
    let db = Firestore.firestore()
    var messages: [Message] = []
    
    //MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextfield: UITextField!
    
    
    //MARK: - Actions
    @IBAction func sendPressed(_ sender: UIButton) {
        if let messageBody = messageTextfield.text, let messageSender =  Auth.auth().currentUser?.email{
            db.collection(FStore.collectionName).addDocument(data: [
                FStore.senderField: messageSender,
                FStore.bodyField: messageBody,
                FStore.dateField: Date().timeIntervalSince1970
            ]) { (error) in
                if let e = error {
                    print("There was an error: \(e.localizedDescription)")
                } else {
                    print("Successfully saved data")
                }
            }
        }
        
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
    
    //Keyboard methods
//    // Обработчик уведомлений о появлении клавиатуры
//    @objc func keyboardWillShow(notification: Notification) {
//        // Получение размера клавиатуры, если она появилась
//        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
//            let height = keyboardSize.height // Получение высоты клавиатуры
//            // Анимация изменения размера таблицы при появлении клавиатуры
//            UIView.animate(withDuration: 0.1, animations: {
//                self.tableView.frame = CGRect(x: self.tableView.frame.origin.x,
//                                              y: self.tableView.frame.origin.y,
//                                              width: self.tableView.frame.width,
//                                              height: self.view.frame.height - height - self.tableView.frame.origin.y)
//            })
//        }
//    }
//    
//    // Обработчик уведомлений об исчезновении клавиатуры
//    @objc func keyboardWillHide(notification: Notification) {
//        // Анимация изменения размера таблицы при исчезновении клавиатуры
//        UIView.animate(withDuration: 0.1, animations: {
//            self.tableView.frame = CGRect(x: self.tableView.frame.origin.x,
//                                          y: self.tableView.frame.origin.y,
//                                          width: self.tableView.frame.width,
//                                          height: self.view.frame.height - self.tableView.frame.origin.y)
//        })
//    }
    
    //MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        navigationBarSetup()
        
        loadMessages()
        
        tableView.register(UINib(nibName: Cells.cellNibName, bundle: nil), forCellReuseIdentifier: Cells.cellIdentifier)
        
        
        
//        // Добавляем в NotificationCenter наблюдателя, который следит за появлением клавиатуры и вызывает функцию keyboardWillShow
//        // object: nil обозначает, что наблюдатель следит за всеми объектами
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
//
//        // Добавляем в NotificationCenter наблюдателя, который следит за скрытием клавиатуры и вызывает функцию keyboardWillHide
//        // object: nil обозначает, что наблюдатель следит за всеми объектами
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    //MARK: - Methods
    
    // Функция для настройки Navigation Bar:
    func navigationBarSetup() {
        
        // Задание цвета для текста Navigation Bar:
        navigationController?.navigationBar.tintColor = UIColor.black
        
        // Скрытие кнопки возврата на предыдущий экран:
        navigationController?.navigationItem.hidesBackButton = true
        
        // Установка названия приложения в качестве заголовка Navigation Bar:
        title = AppName.appName
    }
    
    // Эта функция загружает сообщения из базы данных Firestore
    func loadMessages() {
        
        // Получает файл коллекции сообщений из базы данных Firestore
        db.collection(FStore.collectionName)
        
        //Сортирует сообщения по дате
            .order(by: FStore.dateField)
        
        //"Слушает" файлы на изменения, чтобы сразу отобразить на экране
            .addSnapshotListener() { querySnapshot, error in
                
                // Инициализирует пустой массив для хранения загруженных сообщений
                self.messages = []
                
                // Если произошла ошибка, выводит сообщение об ошибке
                if let e = error {
                    print("Произошла ошибка: \(e.localizedDescription)")
                } else {
                    // Если ошибок нет, извлекает документы из файла
                    if let snapShotDocuments = querySnapshot?.documents {
                        
                        // Перебирает файлы и извлекает отправителя и текст сообщения
                        for doc in snapShotDocuments {
                            let data = doc.data()
                            if let messageSender = data[FStore.senderField] as? String, let messageBody = data[FStore.bodyField] as? String {
                                
                                // Создает новый объект сообщения с отправителем и текстом сообщения и добавляет его в массив сообщений
                                let newMessage = Message(sender: messageSender, body: messageBody)
                                self.messages.append(newMessage)
                                
                                //Обновление таблицы на главном потоке, чтобы пользователь мог взаимодействовать с ней без задержек
                                DispatchQueue.main.async {
                                    self.tableView.reloadData()
                                }
                            }
                        }
                    }
                }
            }
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
