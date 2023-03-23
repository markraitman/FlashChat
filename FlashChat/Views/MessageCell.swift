//
//  MessageCell.swift
//  FlashChat
//
//  Created by Марк Райтман on 20.03.2023.
//

import UIKit

class MessageCell: UITableViewCell {
    
    //MARK: - Outlets
    @IBOutlet weak var messageBubble: UIView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var rightImageView: UIImageView!
    @IBOutlet weak var leftImageView: UIImageView!
    
    //MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        xibViewSetupCorners()
    }

    //MARK: - Methods
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func xibViewSetupCorners() {
        messageBubble.layer.cornerRadius = messageBubble.frame.size.height / 5
    }
    
}
