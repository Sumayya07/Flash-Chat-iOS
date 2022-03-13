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
    
    let db = Firestore.firestore()
    
    
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
        
        loadMessages()

    }
    
    func loadMessages() {
        messages = []
        db.collection(K.FStore.collectionName).getDocuments { (querySnapshot, error) in
            if let e = error {
                print("There is an issue retrieving data from Firestore. \(e)")
            } else {
                if let snapshotDocuments = querySnapshot?.documents{
                    for doc in snapshotDocuments {
                        let data = doc.data()
                       if let messageSender = data[K.FStore.senderField] as? String, let messageBody = data[K.FStore.bodyField] as? String{
                            let newMessage = Message(sender: messageSender, body: messageBody)
                           self.messages.append(newMessage)
                           DispatchQueue.main.async {
                               self.tableView.reloadData() // This will be able to tap into the tableview and trigger those data source methods again. and as we are inside a closure we have to add self keyword.
                           }
                          
                        }
                    }
                }
            }
        }
    }
    // The above function will store our message database and show inside the tableview
    
    @IBAction func sendPressed(_ sender: UIButton) {
        if let messageBody = messageTextfield.text, let messageSender = Auth.auth().currentUser?.email {
            db.collection(K.FStore.collectionName).addDocument(data: [K.FStore.senderField: messageSender, K.FStore.bodyField: messageBody]) { (error) in
                if let e = error {
                    print("There was an issue saving data to firestore, \(e)")
                } else {
                    print("Successfully Saved Data")
                }
            }
        }
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


