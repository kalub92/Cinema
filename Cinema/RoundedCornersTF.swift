//
//  RoundedCornersTF.swift
//  Cinema
//
//  Created by Caleb Stultz on 3/6/16.
//  Copyright © 2016 Caleb Stultz. All rights reserved.
//

import UIKit

class RoundedCornersTF: UITextField {
    
    override func awakeFromNib() {
        layer.cornerRadius = 15.0
        self.clipsToBounds = true
    }

}
