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
    
    let defaults = NSUserDefaults.standardUserDefaults()
    
    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieReview: UILabel!
    @IBOutlet weak var movieURL: UILabel!
    @IBOutlet weak var transparentView: UIView!
    @IBOutlet weak var reviewView: UIStackView!
    
    var movies = [Movie]()
    var indexPath: NSIndexPath!
    var interactor:Interactor? = nil
    
    var fetchedResultsController: NSFetchedResultsController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.clearColor()
        view.opaque = false
    }
    
    override func viewDidAppear(animated: Bool) {
        if (defaults.boolForKey("initialRun") == false) {
            showHelperCircle()
            defaults.setBool(true, forKey: "initialRun")
        }
        defaults.setBool(true, forKey: "initialRun")
    }

    override func viewWillAppear(animated: Bool) {
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
    
    @IBAction func handleGesture(sender: UIPanGestureRecognizer) {
        
        let percentThreshold:CGFloat = 0.1
        
        // convert y-position to downward pull progress (percentage)
        let translation = sender.translationInView(view)
        let verticalMovement = translation.y / view.bounds.height
        let downwardMovement = fmaxf(Float(verticalMovement), 0.0)
        let downwardMovementPercent = fminf(downwardMovement, 1.0)
        let progress = CGFloat(downwardMovementPercent)
        
        guard let interactor = interactor else { return }
        
        switch sender.state {
        case .Began:
            interactor.hasStarted = true
            dismissViewControllerAnimated(true, completion: nil)
        case .Changed:
            interactor.shouldFinish = progress > percentThreshold
            interactor.updateInteractiveTransition(progress)
        case .Cancelled:
            interactor.hasStarted = false
            interactor.cancelInteractiveTransition()
        case .Ended:
            interactor.hasStarted = false
            interactor.shouldFinish
                ? interactor.finishInteractiveTransition()
                : interactor.cancelInteractiveTransition()
        default:
            break
        }
    }
    
    func showHelperCircle(){
        
        let center = CGPoint(x: transparentView.bounds.width * 0.5, y: 100)
        let small = CGSize(width: 30, height: 30)
        let circle = UIView(frame: CGRect(origin: center, size: small))
        circle.center = CGPoint(x: transparentView.bounds.width * 0.5, y: 100)
        circle.layer.cornerRadius = circle.frame.width/2
        circle.backgroundColor = UIColor.whiteColor()
        circle.layer.shadowOpacity = 0.5
        circle.layer.shadowOffset = CGSizeZero
        view.addSubview(circle)
        UIView.animateWithDuration(
            0.5,
            delay: 0.25,
            options: [],
            animations: {
                circle.frame.origin.y += 200
                circle.layer.opacity = 0
            },
            completion: { _ in
                circle.removeFromSuperview()
            }
    )}
    
}