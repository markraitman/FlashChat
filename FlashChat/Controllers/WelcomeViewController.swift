//
//  WelcomeViewController.swift
//  FlashChat
//
//  Created by Марк Райтман on 17.03.2023.
//

import Foundation
import UIKit

class WelcomeViewController: UIViewController {
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

       welcomeAnimation()
    }

    //MARK: - Outlets
    @IBOutlet weak var titleLabel: UILabel!
    
    //MARK: - Methods
    func welcomeAnimation() {
        //Sets a text to the titleLabel.
        titleLabel.text = ""
        
        //Assigning the "⚡️FlashChat" string to the constant variable `titleText`.
        let titleText = "⚡️FlashChat"

        /*
         Initializing a double variable charIndex with 0.0 value
         to increment by 1 for each character in the titleText and create delay.
        */
        var charIndex = 0.0

        //Iterating through each character in the titleText using for-in loop.
        for letter in titleText {
            //Each iteration schedules a timer with a specific delay.
            Timer.scheduledTimer(withTimeInterval: 0.15 * charIndex, repeats: false) { (timer) in
                //In the timer block, append the current letter to titleLabel's text using optional chaining.
                self.titleLabel.text?.append(letter)
            }
            //incrementing the charIndex by 1 after each iteration.
            charIndex += 1
        }
    }

}
