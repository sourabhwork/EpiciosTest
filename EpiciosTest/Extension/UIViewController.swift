//
//  UIViewController.swift
//  EpiciosTest
//
//  Created by Sourabh Kumbhar on 19/12/20.
//  Copyright © 2020 Sourabh Kumbhar. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func showAlert(title: String, message: String, actions: [UIAlertAction] = []) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        if actions.isEmpty {
            let okAction = UIAlertAction(title: ConstantKey.ok, style: .default, handler: nil)
            alertController.addAction(okAction)
        } else {
            for action in actions {
                alertController.addAction(action)
            }
        }
        self.present(alertController, animated: true, completion: nil)
    }
    
    func getCollectionViewBackgroundLabel()-> UILabel {
        let backgroundLbl = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 50))
        backgroundLbl.text = ConstantKey.noDataFound
        backgroundLbl.textColor = UIColor.red
        backgroundLbl.textAlignment = .center
        return backgroundLbl
    }
        
}
