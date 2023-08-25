//
//  Warning.swift
//  Flash Chat iOS13
//
//  Created by Miguel Alejandro Correa Avila on 24/8/23.
//  Copyright © 2023 Angela Yu. All rights reserved.
//

import Foundation
import UIKit

struct Warning {
        
    static let goodColor: CGColor = UIColor.green.withAlphaComponent(0.8).cgColor
    static let badColor: CGColor = UIColor.red.withAlphaComponent(0.8).cgColor
    
    
    static func setBorder(for label:UITextField, to color: Color) {
        label.layer.cornerRadius = 20
        label.layer.borderWidth = 2
        switch color {
        case .good: label.layer.borderColor = goodColor
        case .bad: label.layer.borderColor = badColor
        }
    }
}

enum Color: String {
    case good, bad
}
