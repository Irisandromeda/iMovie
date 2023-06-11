//
//  SignInViewController.swift
//  iMovie
//
//  Created by Irisandromeda on 10.06.2023.
//

import UIKit
import Lottie

class SignInViewController: UIViewController {
    
    @IBOutlet weak var userNameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var buttonAnimation: LottieAnimationView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSubviews()
    }
    
    private func setupSubviews() {
        addImageInTF(userNameTF, name: "username")
        addImageInTF(emailTF, name: "email")
        addImageInTF(passwordTF, name: "password")
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(textFieldShouldReturn))
        view.addGestureRecognizer(gesture)
        
        buttonAnimation.startLottieAnimation("buttonLottie", speed: 1, loopMode: .loop, contentMode: .scaleToFill)
    }
    
    private func addImageInTF(_ textField: UITextField, name: String) {
        textField.leftViewMode = .always
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 32, height: 32))
        imageView.image = UIImage(named: name)
        textField.leftView = imageView
        textField.delegate = self
    }
}

//MARK: TextField Delegate

extension SignInViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}
