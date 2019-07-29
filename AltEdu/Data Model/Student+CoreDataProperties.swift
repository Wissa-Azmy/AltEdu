//
//  Student+CoreDataProperties.swift
//  AltEdu
//
//  Created by Wissa Azmy on 7/29/19.
//  Copyright © 2019 Wissa Michael. All rights reserved.
//
//

import Foundation
import CoreData


extension Student {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Student> {
        return NSFetchRequest<Student>(entityName: "Student")
    }

    @NSManaged public var name: String?
    @NSManaged public var lesson: Lesson?

}
