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
    @IBOutlet weak var transparentView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        aboutView.layer.cornerRadius = 15.0
        aboutView.clipsToBounds = true
    }
    
    override func viewWillAppear(animated: Bool) {
        UIView.animateWithDuration(0.7, animations: {
            self.transparentView.alpha = 0.7
        })
    }

    @IBAction func returnHome(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }

}
