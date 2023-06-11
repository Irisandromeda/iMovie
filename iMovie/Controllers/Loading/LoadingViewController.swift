//
//  LoadingViewController.swift
//  iMovie
//
//  Created by Irisandromeda on 10.06.2023.
//

import UIKit
import Lottie

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
        let viewController = SignInViewController(nibName: "SignInViewController", bundle: nil)
        viewController.modalPresentationStyle = .overFullScreen
        present(viewController, animated: true)
    }

}
