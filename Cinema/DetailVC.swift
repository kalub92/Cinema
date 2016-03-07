//
//  DetailVC.swift
//  Cinema
//
//  Created by Caleb Stultz on 3/8/16.
//  Copyright © 2016 Caleb Stultz. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class DetailVC: UIViewController {

    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieReview: UILabel!
    @IBOutlet weak var movieURL: UILabel!
    
    var movies = [Movie]()
 
    var fetchedResultsController: NSFetchedResultsController!
    
    override func viewDidAppear(animated: Bool) {
        fetchAndSetResults()
    }
    
    func fetchAndSetResults() {
        let app = UIApplication.sharedApplication().delegate as! AppDelegate
        let context = app.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: "Movie")

        do {
            let results = try context.executeFetchRequest(fetchRequest)
            self.movies = results as! [Movie]
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }

    
    @IBAction func cancelBtn(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}