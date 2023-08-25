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
    
    let db = Firestore.firestore()
    
    var messages: [Message] = [
        .init(sender: "123@c.com", body: "Hello C, how you doing?"),
        .init(sender: "123@c.com", body: "are you there?"),
        .init(sender: "c@c.com", body: "yeah I'm here. All good and you?"),
        .init(sender: "c@c.com", body: "auf hauifgh aiuhreip ahuiper guhpair hgpah erpgh upriehg ahuerg huauiehglahurgluhaileghuareug hpiarhg paruh gpahrgp aherpg hañerg ñhaiegpñraieroñ añorg añrg"),
        
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        getViewReady()
        
        tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
        
    }
    
    @IBAction func sendPressed(_ sender: UIButton) {
        db.collection("users").addDocument(data: [
            "first": "Ada",
            "last": "Lovelace",
            "born": 1815
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added")
            }
        }
    }
    
    
    @IBAction func logoutPressed(_ sender: UIBarButtonItem) {
        do{
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch {presentError(e: error)}
    }
    
    
    
    func presentError (e:Error)  {
        let alert = UIAlertController(title: "An error ocurred", message: e.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default))
        self.present(alert, animated: true, completion: nil)
    }
    
    func getViewReady() {
        navigationItem.hidesBackButton = true
        title = "⚡️FlashChat"
    }
}

extension ChatViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! MessageCell
        cell.label?.text = messages[indexPath.row].body
        return cell
    }
    
    
}
