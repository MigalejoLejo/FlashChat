//
//  ChatViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class ChatViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextfield: UITextField!
    var scrollAnimation: Bool = false
    
    let db = Firestore.firestore()
    
    var messages: [Message] = []
    
    
    
    // MARK: - View Preparation
    override func viewWillAppear(_ animated: Bool) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)

        navigationItem.hidesBackButton = true
        title = "⚡️FlashChat"
        
        loadMessages()

        
    }
    
    
    
    // MARK: - IBActions
    @IBAction func sendPressed(_ sender: UIButton) {
        if let message = messageTextfield.text, let sender = Auth.auth().currentUser?.email {
            let date = Date().timeIntervalSince1970
            db.collection(K.FStore.collectionName).addDocument(data: [
                K.FStore.dateField: date,
                K.FStore.bodyField: message,
                K.FStore.senderField: sender
            ]) { err in
                if let err = err {
                    print("Error adding document: \(err)")
                } else {
                    self.messages.append(.init(sender: sender, body: message, date: date))
                    self.messageTextfield.text = ""
                }
            }
        }
      
    }
    
    @IBAction func logoutPressed(_ sender: UIBarButtonItem) {
        do{
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch {presentError(e: error)}
    }
    
    
    
    // MARK: - Functions
    func presentError (e:Error)  {
        let alert = UIAlertController(title: "An error ocurred", message: e.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    func loadMessages() {
        db.collectionGroup(K.FStore.collectionName)
            .order(by: K.FStore.dateField)
            .addSnapshotListener { result, error in
            if let e = error {
                print(e.localizedDescription)
            } else {
                self.messages = []
                if let documents = result?.documents {
                    for document in documents {
                        let data = document.data()
                        let message: Message = .init(sender: data[K.FStore.senderField] as! String, body: data[K.FStore.bodyField] as! String, date: data[K.FStore.dateField] as! Double)
                        self.messages.append(message)
                        

                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                            let indexPath = IndexPath(row: self.messages.count-1, section: 0)
                            self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: self.scrollAnimation)
                            if !self.scrollAnimation {
                                self.scrollAnimation = true
                            }
                        }
                    }
                }
            }
        }
        
    }
}





// MARK: - UITableViewDataSource
extension ChatViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = messages[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! MessageCell
        cell.label?.text = message.body

        if message.sender == Auth.auth().currentUser?.email {
            cell.leftImageView.isHidden = true
            cell.rightImageView.isHidden = false
            cell.messageBubble.backgroundColor = UIColor(named: K.BrandColors.lightPurple)
            cell.label.textColor = UIColor(named: K.BrandColors.purple)
            cell.label.textAlignment = .right
        } else {
            cell.leftImageView.isHidden = false
            cell.rightImageView.isHidden = true
            cell.messageBubble.backgroundColor = UIColor(named: K.BrandColors.purple)
            cell.label.textColor = UIColor(named: K.BrandColors.lightPurple)
        }
        return cell
    }
    
    
}
