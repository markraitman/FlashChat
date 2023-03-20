//
//  Constants.swift
//  FlashChat
//
//  Created by Марк Райтман on 20.03.2023.
//

import Foundation
import UIKit

//MARK: - AppName
enum AppName {
    static let appName = "⚡️FlashChat"
}

//MARK: - Segues
enum Segues {
    static let registerSegue: String = "RegisterToChat"
    static let loginSegue: String = "LoginToChat"
}

//MARK: - Cells
enum Cells {
    static let cellIdentifier: String = "ReusableCell"
    static let cellNibName: String = "MessageCell"
}

//MARK: - BrandColors
enum BrandColors {
    static let purple: String = "BrandPurple"
    static let lightPurple: String = "BrandLightPurple"
    static let blue: String = "BrandBlue"
    static let lighBlue: String = "BrandLightBlue"
}

//MARK: - FStore
enum FStore {
    static let collectionName: String = "messages"
    static let senderField: String = "sender"
    static let bodyField: String = "body"
    static let dateField: String = "date"
}
