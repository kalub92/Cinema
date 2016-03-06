//
//  Movie.swift
//  Cinema
//
//  Created by Caleb Stultz on 3/6/16.
//  Copyright © 2016 Caleb Stultz. All rights reserved.
//

import Foundation
import CoreData
import UIKit


class Movie: NSManagedObject {

    func setMovieImage(img: UIImage) {
        let data = UIImagePNGRepresentation(img)
        self.image = data
    }
    
    func getMovieImg() -> UIImage {
        let img = UIImage(data: self.image!)
        return img!
    }

}
