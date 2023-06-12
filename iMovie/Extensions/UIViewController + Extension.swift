//
//  UIViewController + Extension.swift
//  iMovie
//
//  Created by Irisandromeda on 11.06.2023.
//

import UIKit

extension UIViewController {
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Okey", style: .default)
        alert.addAction(alertAction)
        present(alert, animated: true)
    }
    
}
