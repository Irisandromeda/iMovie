//
//  BottomCell.swift
//  iMovie
//
//  Created by Irisandromeda on 16.06.2023.
//

import UIKit
import FirebaseAuth

class BottomCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @IBAction func signOutAction(_ sender: UIButton) {
        do {
            try Auth.auth().signOut()
            let viewController = SignUpViewController(nibName: "SignUpViewController", bundle: nil)
            UIApplication.shared.windows.first?.rootViewController = viewController
        } catch {
            print("Error signing out: \(error.localizedDescription)")
        }
    }
    
}
