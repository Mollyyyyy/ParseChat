//
//  ChatViewController.swift
//  ParseChat
//
//  Created by Apple on 2/23/17.
//  Copyright © 2017 Xinmeng Li. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var messages:[String]!
    
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var messagetextfield: UITextField!
    @IBOutlet weak var messageTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        messageTableView.delegate = self
        messageTableView.dataSource = self
        messageTableView.estimatedRowHeight = 100
        messageTableView.rowHeight = UITableViewAutomaticDimension
        Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(ChatViewController.reload), userInfo: nil, repeats: true)
        
        // Do any additional setup after loading the view.
    }
    func reload() {
        let query = PFQuery(className: "Message")
        query.addDescendingOrder("createdAt")
        query.includeKey("user")
        query.findObjectsInBackground { (objects, error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
               /* if let objects = objects {
                    for object in objects {
                        let text = object["text"] as? String
                        if text != "" {
                            let username = (chat["user"] as? PFUser)?.username
                        }
                    }
                }*/
            }
        }
        messageTableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let messages = messages{
            return messages.count
        }
        else{
            return 0
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath) as! MessageCell
        cell.message = messages[indexPath.row]
        cell.messageLabel.text = cell.message
        return cell
    }
    
    @IBAction func messageAction(_ sender: Any) {
        let message = PFObject(className:"Message")
        message["text"] = messagetextfield.text
        message.saveInBackground {
            (success: Bool, error: Error?) -> Void in
            if (success) {
                // The object has been saved.
                print("succeed in creating messages")
            } else {
                print(error?.localizedDescription )
                // There was a problem, check error.description
            }
        }
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
