//
//  WelcomeViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import CLTypingLabel

class WelcomeViewController: UIViewController {
    
    
    @IBOutlet weak var titleLabel: CLTypingLabel!
    @IBOutlet weak var secondaryTitleLabel: CLTypingLabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTitleLabel()
        
        
       
        
        
        
    }
    
    @objc func labelTapped(_ sender: UITapGestureRecognizer) {
        secondaryTitleLabel.isHidden = true
        titleLabel.text = "FlashChat"
    }
    
    
    func setUpTitleLabel() {
        secondaryTitleLabel.isHidden = true
        titleLabel.onTypingAnimationFinished = {
            self.secondaryTitleLabel.isHidden = false
        }
        let labelTap = UITapGestureRecognizer(target: self, action: #selector(self.labelTapped(_:)))
        titleLabel.isUserInteractionEnabled = true
        titleLabel.addGestureRecognizer(labelTap)
        
        titleLabel.text = "FlashChat"
    }
}
