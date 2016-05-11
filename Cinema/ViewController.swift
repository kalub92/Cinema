//
//  ViewController.swift
//  Cinema
//
//  Created by Caleb Stultz on 3/6/16.
//  Copyright © 2016 Caleb Stultz. All rights reserved.
//

import UIKit
import CoreData
import SwiftLoader
    
class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var semiTransparentView: UIView!
    @IBOutlet weak var arrowPointer: UIView!
    @IBOutlet weak var nothingHereLbl: UILabel!
    @IBOutlet weak var transparentView: UIView!
    @IBOutlet weak var transView: UIView!
    
    var movies = [Movie]()
    var myData: Array<AnyObject> = []
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    let interactor = Interactor()
    let detailViewController = DetailVC()
    let noPostsViewController = NoPostsVC()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        semiTransparentView.alpha = 0.5
        
        transView.alpha = 0.7
        SwiftLoader.show(title: "Loading...", animated: true)
    
    }
    
    override func viewDidAppear(animated: Bool) {
        fetchAndSetResults()
        tableView.reloadData()
        
        if tableView.numberOfRowsInSection(movies.count) >= 1 {
            self.arrowPointer.hidden = true
            self.nothingHereLbl.hidden = true
            self.semiTransparentView.hidden = true
            self.arrowPointer.alpha = 0
            self.nothingHereLbl.alpha = 0
            self.semiTransparentView.alpha = 0
        }
        
        SwiftLoader.hide()
        fadeOut()
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
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCellWithIdentifier("MovieCell") as? MovieCell {
            
            let movie = movies[indexPath.row]
            cell.configureCell(movie)
            return cell
        } else {
            return MovieCell()
        }
            
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func getMovie(indexPath: NSIndexPath) -> Movie {
        return self.movies[indexPath.row]
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
        let appDel:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context:NSManagedObjectContext = appDel.managedObjectContext
        context.deleteObject(movies[indexPath.row] as NSManagedObject)
        movies.removeAtIndex(indexPath.row)
        do {
            try context.save()
        } catch {
            print("Error, data not saved!")
        }
        tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
            
            if tableView.numberOfRowsInSection(movies.count) == 0 {
                self.arrowPointer.hidden = false
                self.nothingHereLbl.hidden = false
                self.semiTransparentView.hidden = false
                UIView.animateWithDuration(0.2, animations: {
                    self.arrowPointer.alpha = 1
                    self.nothingHereLbl.alpha = 1
                    self.semiTransparentView.alpha = 0.5
                })
            }
        }
    }
    
    func fadeIn() {
            self.navigationController?.view.addSubview(transView)
            UIView.animateWithDuration(0.2, animations: {
                self.transView.alpha = 0.7
            })
        }
    
    func fadeOut() {
        UIView.animateWithDuration(0.2, animations: {
            self.transView.alpha = 0
        })
    }

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if let destinationViewController = segue.destinationViewController as? DetailVC {
            destinationViewController.transitioningDelegate = self
            destinationViewController.interactor = interactor // new
            
            if segue.identifier == "loadDetail" {
                if let selectedMovieCell = sender as? MovieCell {
                    destinationViewController.indexPath = tableView.indexPathForCell(selectedMovieCell)
                }
                
                fadeIn()
            }
        }
    }
}

    extension ViewController: UIViewControllerTransitioningDelegate {
        func interactionControllerForDismissal(animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
            return interactor.hasStarted ? interactor : nil
        }
        func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
            return DismissAnimator()
        }
}