//
//  TransparentBlack.swift
//  Cinema
//
//  Created by Caleb Stultz on 3/7/16.
//  Copyright © 2016 Caleb Stultz. All rights reserved.
//

import UIKit

class TransparentBlack: UIView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.backgroundColor = UIColor.blackColor()
        self.alpha = 0.7
        
    }

}
