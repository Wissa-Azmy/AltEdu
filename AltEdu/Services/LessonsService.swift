//
//  LessonsService.swift
//  AltEdu
//
//  Created by Wissa Azmy on 8/8/19.
//  Copyright © 2019 Wissa Michael. All rights reserved.
//

import Foundation
import CoreData

enum LessonType: String {
    case ios, android
}

typealias StudentHandler = (Bool, [Student]) -> ()

class LessonsService {
    private var moc: NSManagedObjectContext
    private var students = [Student]()
    
    init(moc: NSManagedObjectContext) {
        self.moc = moc
    }
    
    // MARK: - Public Methods
    
    // CREATE
    func addStudent(name: String, for type: LessonType, completion: StudentHandler) {
        let student = Student(context: moc)
        student.name = name
        
        if let lesson = lessonExists(type) {
            register(student, for: lesson)
            students.append(student)
            
            completion(true, students)
            return
        }
        
        completion(false, students)
    }
    
    // READ
    func getStudens() -> [Student]? {
        let sortByLesson = NSSortDescriptor(key: "lesson.type", ascending: true)
        let sortByName = NSSortDescriptor(key: "name", ascending: true)
        let sortDescriptors = [sortByLesson, sortByName]
        
        let request: NSFetchRequest<Student> = Student.fetchRequest()
        request.sortDescriptors = sortDescriptors
        
        var students: [Student]?
        do {
            students = try moc.fetch(request)
        } catch  {
            print("Error reading students list: \(error.localizedDescription)")
        }
        
        return students
    }
    
    // MARK: - Private Methods
    
    // TODO: - Check if lesson Exists
    private func lessonExists(_ type: LessonType) -> Lesson? {
        let request: NSFetchRequest<Lesson> = Lesson.fetchRequest()
        request.predicate = NSPredicate(format: "type = %@", type.rawValue)
        
        var lesson: Lesson?
        do {
            let result = try moc.fetch(request)
            lesson = result.isEmpty ? addNew(lesson: type) : result.first
        } catch {
            print("Error getting lesson: \(error.localizedDescription)")
        }
        
        return lesson
    }
    
    // TODO: - Add New lesson if it doesn't exist
    private func addNew(lesson type: LessonType) -> Lesson {
        let lesson = Lesson(context: moc)
        lesson.type = type.rawValue
        
        return lesson
    }
    
    // TODO: - Register Student to lesson
    private func register(_ student: Student, for lesson: Lesson) {
        student.lesson = lesson
    }
    
    // TODO: - Save Context
    private func save() {
        do {
            try moc.save()
        } catch {
            print("Error saving data: \(error.localizedDescription)")
        }
    }
}
