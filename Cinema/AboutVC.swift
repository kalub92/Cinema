//
//  AboutVC.swift
//  Cinema
//
//  Created by Caleb Stultz on 3/6/16.
//  Copyright © 2016 Caleb Stultz. All rights reserved.
//

import UIKit

class AboutVC: UIViewController {

    @IBOutlet weak var aboutView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        aboutView.layer.cornerRadius = 15.0
        aboutView.clipsToBounds = true
    }

    @IBAction func returnHome(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }

}
