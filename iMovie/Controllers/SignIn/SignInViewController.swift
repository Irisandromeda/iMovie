//
//  SignInViewController.swift
//  iMovie
//
//  Created by Irisandromeda on 11.06.2023.
//

import UIKit
import Lottie

class SignInViewController: UIViewController {
    
    //Outlets
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var buttonAnimation: LottieAnimationView!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupSubviews()
    }
    
    private func setupSubviews() {
        addImageInTF(emailTF, name: "email")
        addImageInTF(passwordTF, name: "password")
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(textFieldShouldReturn))
        view.addGestureRecognizer(gesture)
        
        buttonAnimation.startLottieAnimation("buttonLottie", speed: 0.8, loopMode: .loop, contentMode: .scaleToFill)
    }
    
    private func addImageInTF(_ textField: UITextField, name: String) {
        textField.leftViewMode = .always
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 32, height: 32))
        imageView.image = UIImage(named: name)
        textField.leftView = imageView
        textField.delegate = self
    }
    
    @IBAction func loginClick(_ sender: UIButton) {
        self.view.endEditing(true)
        guard (emailTF.text != nil), passwordTF.text != nil else {
            print("Fields are empty")
            showAlert(title: "Something was wrong!", message: "Fields are empty")
            return
        }
        
        AuthService.service.login(email: emailTF.text, password: passwordTF.text) { result in
            switch result {
                
            case .success(let user):
                print("Login - Success")
                FireStoreService.shared.getUserData(user: user) { result in
                    switch result {
                        
                    case .success(let user):
                        let viewController = TabBarController(user: user)
                        viewController.modalPresentationStyle = .overFullScreen
                        self.present(viewController, animated: true)
                    case .failure(let error):
                        print("We have not received user data - \(error.localizedDescription)")
                    }
                }
            case .failure(let error):
                print("Login Error")
                self.showAlert(title: "Something was wrong!", message: error.localizedDescription)
            }
        }
    }
    
    @IBAction func openRegisterScreen(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
}

//MARK: TextField Delegate

extension SignInViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}
