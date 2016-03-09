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
    var indexPath: NSIndexPath!
 
    var fetchedResultsController: NSFetchedResultsController!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        fetchAndSetResults()
        let movie = movies[indexPath.row]
        configureDetails(movie)
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
    
    func configureDetails(movie: Movie) {
        movieTitle.text = movie.title
        moviePoster.image = movie.getMovieImg()
        movieReview.text = movie.review
        movieURL.text = movie.link
    }

    
    @IBAction func cancelBtn(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}