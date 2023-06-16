//
//  SignUpViewController.swift
//  iMovie
//
//  Created by Irisandromeda on 10.06.2023.
//

import UIKit
import Lottie

class SignUpViewController: UIViewController {
    
    //Outlets
    @IBOutlet weak var userNameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var buttonAnimation: LottieAnimationView!
    @IBOutlet weak var successLottie: LottieAnimationView!
    
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
        
        buttonAnimation.startLottieAnimation("buttonLottie", speed: 0.8, loopMode: .loop, contentMode: .scaleToFill)
    }
    
    private func addImageInTF(_ textField: UITextField, name: String) {
        textField.leftViewMode = .always
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 32, height: 32))
        imageView.image = UIImage(named: name)
        textField.leftView = imageView
        textField.delegate = self
    }
    
    @IBAction func registrationClick(_ sender: UIButton) {
        self.view.endEditing(true)
        guard (userNameTF.text != nil), (emailTF.text != nil), passwordTF.text != nil else {
            print("Fields are empty")
            return
        }
        
        AuthService.service.registration(email: emailTF.text, password: passwordTF.text) { result in
            switch result {
                
            case .success(let user):
                print("Registration Success with E-mail - \(user.email!), ID - \(user.uid)")
                AuthService.service.confirmEmail()
                FireStoreService.shared.saveUserData(userID: user.uid, email: user.email!, username: self.userNameTF.text!) { result in
                    switch result {
                        
                    case .success(_):
                        print("UserData - Saved")
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
                self.successLottie.startLottieAnimation("successLottie", speed: 1, loopMode: .playOnce, contentMode: .scaleToFill)
            case .failure(let error):
                print(error.localizedDescription)
                self.showAlert(title: "Something was wrong!", message: error.localizedDescription)
            }
        }
    }
    
    @IBAction func openLoginScreen(_ sender: UIButton) {
        let viewController = SignInViewController(nibName: "SignInViewController", bundle: nil)
        viewController.modalPresentationStyle = .overFullScreen
        present(viewController, animated: true)
    }
    
}

//MARK: TextField Delegate

extension SignUpViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}
