//
//  Movie+CoreDataProperties.swift
//  Cinema
//
//  Created by Caleb Stultz on 3/12/16.
//  Copyright © 2016 Caleb Stultz. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Movie {

    @NSManaged var image: NSData?
    @NSManaged var link: String?
    @NSManaged var review: String?
    @NSManaged var title: String?

}
