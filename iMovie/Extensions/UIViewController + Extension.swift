//
//  UIViewController + Extension.swift
//  iMovie
//
//  Created by Irisandromeda on 10.06.2023.
//

import UIKit
import Lottie

extension LottieAnimationView {
    func startLottieAnimation(_ name: String, speed: CGFloat, loopMode: LottieLoopMode, contentMode: ContentMode) {
        self.animation = LottieAnimation.named(name)
        self.animationSpeed = speed
        self.loopMode = loopMode
        self.contentMode = contentMode
        self.play()
    }
}
