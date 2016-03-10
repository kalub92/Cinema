//
//  AddMovieVC.swift
//  Cinema
//
//  Created by Caleb Stultz on 3/6/16.
//  Copyright © 2016 Caleb Stultz. All rights reserved.
//

import UIKit
import CoreData

class AddMovieVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var addMovieView: UIView!
    @IBOutlet weak var movieImg: RoundedCornersVC!
    @IBOutlet weak var movieTitle: RoundedCornersTF!
    @IBOutlet weak var movieReview: RoundedCornersTF!
    @IBOutlet weak var imdbLink: RoundedCornersTF!
    var imagePicker: UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        addMovieView.layer.cornerRadius = 15.0
        addMovieView.clipsToBounds = true
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        imagePicker.dismissViewControllerAnimated(true, completion: nil)
        movieImg.image = image
    }
    
    @IBAction func addImage(sender: AnyObject!) {
        presentViewController(imagePicker, animated: true, completion: nil)
        sender.setTitle("CHANGE IMAGE", forState: .Normal)
    }
    
    @IBAction func createMovie(sender: AnyObject) {
        if let title = movieTitle.text where title != "", let image = movieImg.image where image != .None {
            
            let app = UIApplication.sharedApplication().delegate as! AppDelegate
            let context = app.managedObjectContext
            let entity = NSEntityDescription.entityForName("Movie", inManagedObjectContext: context)!
            let movie = Movie(entity: entity, insertIntoManagedObjectContext: context)
            movie.title = title
            movie.review = movieReview.text
            movie.link = imdbLink.text
            movie.setMovieImage(movieImg.image!)
            
            context.insertObject(movie)
            
            do {
                try context.save()
            } catch {
                print("Could not save movie")
            }
            
            self.dismissViewControllerAnimated(true, completion: nil)
            
    }
}
    
    @IBAction func onCancelPressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }

}



