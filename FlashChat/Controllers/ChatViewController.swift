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

class ChatViewController: UIViewController {
    
    //MARK: - Properties
    let db = Firestore.firestore()
    var messages: [Message] = []
    
    //MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextfield: UITextField!
    
    
    //MARK: - Actions
    // Обработчик нажатия кнопки "Оправить"
    @IBAction func sendPressed(_ sender: UIButton) {
        
        // Проверяем, что текст сообщения и email отправителя существуют
        if let messageBody = messageTextfield.text, let messageSender =  Auth.auth().currentUser?.email{
            
            // Добавляем данные в Firestore
            db.collection(FStore.collectionName).addDocument(data: [
                FStore.senderField: messageSender,
                FStore.bodyField: messageBody,
                FStore.dateField: Date().timeIntervalSince1970
            ]) { (error) in
                if let e = error {
                    // Обработка ошибки
                    print("There was an error: \(e.localizedDescription)")
                } else {
                    print("Successfully saved data")
                    
                    //Очищаем на главном потоке поле строки для ввода следующего сообщения после сохранения
                    DispatchQueue.main.async {
                        self.messageTextfield.text = ""
                    }
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
    
    //MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        navigationBarSetup()
        
        loadMessages()
        
        tableView.register(UINib(nibName: Cells.cellNibName, bundle: nil), forCellReuseIdentifier: Cells.cellIdentifier)
    }
    
    //MARK: - Methods
    
    // Функция для настройки Navigation Bar:
    func navigationBarSetup() {
        
        // Задание цвета для текста Navigation Bar:
        navigationController?.navigationBar.tintColor = UIColor.white
        
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
                                    
                                    let indexPath = IndexPath(row: self.messages.count - 1, section: 0)
                                    self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
                                    
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
    // Функция, возвращающая количество строк в таблице
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        messages.count
    }
    
    // Функция для создания ячейки таблицы
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = messages[indexPath.row]
        
        // Инициализация ячейки из таблицы
        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.cellIdentifier, for: indexPath) as! MessageCell
        cell.label.text = message.body
        
        // Если отправитель сообщения - текущий пользователь, то делаем видимой правую картинку-иконку, иначе - левую
        if message.sender == Auth.auth().currentUser?.email {
            cell.leftImageView.isHidden = true
            cell.rightImageView.isHidden = false
            cell.messageBubble.backgroundColor = UIColor(named: BrandColors.lightPurple)
            cell.label.textColor = UIColor(named: BrandColors.purple)
        } else {
            cell.leftImageView.isHidden = false
            cell.rightImageView.isHidden = true
            cell.messageBubble.backgroundColor = UIColor(named: BrandColors.purple)
            cell.label.textColor = UIColor(named: BrandColors.lightPurple)
        }
        
        return cell
    }
    
    
}
