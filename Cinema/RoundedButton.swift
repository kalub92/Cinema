//
//  RoundedButton.swift
//  Cinema
//
//  Created by Caleb Stultz on 5/8/16.
//  Copyright © 2016 Caleb Stultz. All rights reserved.
//

import UIKit

class RoundedButton: UIButton {

    override func awakeFromNib() {
        self.layer.cornerRadius = 5.0   
        self.backgroundColor = UIColor.whiteColor()
        layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5).CGColor
        layer.shadowOpacity = 0.8
        layer.shadowRadius = 5.0
        layer.shadowOffset = CGSizeMake(0.0, 2.0)
    }

}
