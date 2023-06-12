//
//  TopCell.swift
//  iMovie
//
//  Created by Irisandromeda on 12.06.2023.
//

import UIKit
import Lottie

class TopCell: UITableViewCell {
    
    //Outlets
    @IBOutlet weak var profileAnimation: LottieAnimationView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        profileAnimation.startLottieAnimation("profileLottie", speed: 1, loopMode: .loop, contentMode: .scaleToFill)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
}
