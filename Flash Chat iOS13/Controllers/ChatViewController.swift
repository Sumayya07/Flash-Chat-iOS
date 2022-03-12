//
//  ChatViewController.swift
//  Flash Chat iOS13
//
//  Created by saeem  on 28/02/22.
//  Copyright © 2022 Saeem. All rights reserved.
//

import UIKit
import Firebase


class ChatViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextfield: UITextField!
    
    
    var messages: [Message] = [
        Message(sender: "saeem92@flashchat.com", body: "Hey!"),
        Message(sender: "saeem92@flashchat.com", body: "Hello!"),
        Message(sender: "saeem92@flashchat.com", body: "What's up?")
    ]
    // I have created a new variable above called messages which will contain an array of message objects.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.dataSource = self
        
        
        title = K.appName
        navigationItem.hidesBackButton = true
        
        tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)

    }
    
    @IBAction func sendPressed(_ sender: UIButton) {
    }
    
    @IBAction func logOutPressed(_ sender: UIBarButtonItem) {
        
    do {
        try Auth.auth().signOut()
        navigationController?.popToRootViewController(animated: true)
    } catch let signOutError as NSError {
      print("Error signing out: %@", signOutError)
    }
      
    }
    
}

extension ChatViewController: UITableViewDataSource { // TabelviewDatasource is responsible for populating the table view telling it how many cell it needs and which cell that put into the tableview
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath)
        as! MessageCell // as! keyword is used here to cast the reusable cell as a message cell class
        cell.label.text = messages[indexPath.row].body
        return cell
    }
    // This means when our table view loads up its going to make a request for data
    
}


