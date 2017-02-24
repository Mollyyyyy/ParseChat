//
//  MessageCell.swift
//  Pods
//
//  Created by Apple on 2/23/17.
//
//

import UIKit
import Parse
class MessageCell: UITableViewCell {
    var message: String!
    @IBOutlet weak var messageLabel: UILabel!
    override func awakeFromNib() {
        
        super.awakeFromNib()
    Timer.scheduledTimer(timeInterval: 5, target: self, selector: "onTimer", userInfo: nil, repeats: true)
        // Initialization code
    }
    func onTimer() {
 
    }
    override func setSelected(_ selected: Bool, animated: Bool) {

        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
