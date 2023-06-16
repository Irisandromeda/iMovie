//
//  LoadingViewController.swift
//  iMovie
//
//  Created by Irisandromeda on 10.06.2023.
//

import UIKit
import Lottie
import FirebaseAuth

class LoadingViewController: UIViewController {
    
    @IBOutlet weak var backgroundAnimation: LottieAnimationView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        startTimer()
        setupSubviews()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .darkContent
    }
    
    private func setupSubviews() {
        backgroundAnimation.startLottieAnimation("lightLoadingLottie", speed: 1.25, loopMode: .loop, contentMode: .scaleAspectFill)
    }
    
    private func startTimer() {
        Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(startApplication), userInfo: nil, repeats: false)
    }
    
    @objc private func startApplication() {
        loginCheck()
    }
    
    private func loginCheck() {
        if let user = Auth.auth().currentUser {
            FireStoreService.shared.getUserData(user: user) { result in
                switch result {
                    
                case .success(let user):
                    let viewController = TabBarController(user: user)
                    viewController.modalPresentationStyle = .overFullScreen
                    self.present(viewController, animated: true)
                case .failure(_):
                    print("The user is not authorized yet")
                }
            }
        } else {
            let viewController = SignUpViewController(nibName: "SignUpViewController", bundle: nil)
            viewController.modalPresentationStyle = .overFullScreen
            self.present(viewController, animated: true)
        }
    }

}
