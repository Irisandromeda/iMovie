//
//  LoadingViewController.swift
//  iMovie
//
//  Created by Irisandromeda on 10.06.2023.
//

import UIKit
import Lottie

class LoadingViewController: UIViewController {
    
    @IBOutlet weak var startAnimation: LottieAnimationView!
    
    var timer: Timer?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        timer = Timer(timeInterval: 3, target: self, selector: #selector(startTimer), userInfo: nil, repeats: false)
        startLottieAnimation()
    }
    
    @objc private func startTimer() {
        
    }
    
    private func startLottieAnimation() {
        startAnimation.animation = LottieAnimation.named("startScreenLottie")
        startAnimation.loopMode = .loop
        startAnimation.contentMode = .scaleAspectFill
        startAnimation.animationSpeed = 1.25
        startAnimation.play()
    }

}
