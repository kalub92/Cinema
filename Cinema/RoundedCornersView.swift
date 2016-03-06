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
        layer.cornerRadius = 5.0
        self.clipsToBounds = true
    }
}
