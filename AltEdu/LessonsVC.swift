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
    private var studentsList = [Student]()

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "AltEdu"
        tableView.delegate = self
        tableView.dataSource = self
        
        getAllStudents()
    }

    // MARK: - Private
    @IBAction func addBtnTapped(_ sender: UIBarButtonItem) {
        presentAlertController(actionType: "add")
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
                            self?.studentsList = students
                        }
                    })
                }
            }
            
            DispatchQueue.main.async {
                self?.getAllStudents()
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .default) { (action) in
            
        }
        
        alertController.addAction(defaultAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true)
    }
    
    private func getAllStudents() {
        if let students = lessonsService?.getStudens() {
            studentsList = students
            tableView.reloadData()
        }
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
        return studentsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StudentCell", for: indexPath)
        
        // Configure the cell...
        cell.textLabel?.text = studentsList[indexPath.row].name
        cell.detailTextLabel?.text = studentsList[indexPath.row].lesson?.type
        
        return cell
    }
}
