//
//  LessonsTableVC.swift
//  AltEdu
//
//  Created by Wissa Azmy on 7/29/19.
//  Copyright © 2019 Wissa Michael. All rights reserved.
//

import UIKit
import CoreData

class LessonsVC: UIViewController {
    
    var moc: NSManagedObjectContext? {
        didSet {
            if let moc = moc {
                lessonsService = LessonsService(moc: moc)
            }
        }
    }
    
    private var lessonsService: LessonsService?
    private var students = [Student]()

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "AltEdu"
    }

    // MARK: - Private
    @IBAction func addBtnTapped(_ sender: UIBarButtonItem) {
        presentAlertController(actionType: "Add")
    }
    
    private func presentAlertController(actionType: String) {
        let alertController = UIAlertController(title: "AltEdu Lesson", message: "Student Info", preferredStyle: .alert)
        
        alertController.addTextField { (nameTextField) in
            nameTextField.placeholder = "Name"
        }
        alertController.addTextField { (lessonTypeTxtField) in
            lessonTypeTxtField.placeholder = "Lesson Type: iOS | Android"
        }
        
        let defaultAction = UIAlertAction(title: actionType.uppercased(), style: .default) { [weak self] (action) in
            guard let studentName = alertController.textFields?.first?.text,
                let lesson = alertController.textFields?.last?.text else { return }
            
            if actionType.caseInsensitiveCompare("add") == .orderedSame {
                if let lessonType = LessonType(rawValue: lesson.lowercased()) {
                    self?.lessonsService?.addStudent(name: studentName, for: lessonType, completion: { (success, students) in
                        if success {
                            self?.students = students
                        }
                    })
                }
            }
            
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .default) { (action) in
            
        }
        
        alertController.addAction(defaultAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true)
    }

}

// MARK: - Table view data source
extension LessonsVC: UITableViewDelegate, UITableViewDataSource {
    
       func numberOfSections(in tableView: UITableView) -> Int {
           // #warning Incomplete implementation, return the number of sections
           return 1
       }

       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           // #warning Incomplete implementation, return the number of rows
           return 2
       }

       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

           // Configure the cell...

           return cell
       }
}
