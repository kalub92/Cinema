//
//  RoundedCornersView.swift
//  Cinema
//
//  Created by Caleb Stultz on 3/6/16.
//  Copyright © 2016 Caleb Stultz. All rights reserved.
//

import UIKit

class RoundedCornersView: UIView {

    override func awakeFromNib() {
        layer.cornerRadius = 15.0
        self.clipsToBounds = true
        self.layer.shadowColor = UIColor.blackColor().CGColor
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 30
        self.layer.shadowOffset = CGSize(width: 5, height: 5)
    }
}
