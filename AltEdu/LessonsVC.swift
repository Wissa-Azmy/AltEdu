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

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "AltEdu"
    }

    // MARK: - Private
    @IBAction func addBtnTapped(_ sender: UIBarButtonItem) {
        presentAlertController(actionType: "Add")
    }
    
    // MARK: - Table view data source
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
 

    private func presentAlertController(actionType: String) {
        let alertController = UIAlertController(title: "AltEdu Lesson", message: "Student Info", preferredStyle: .alert)
        
        alertController.addTextField { (nameTextField) in
            nameTextField.placeholder = "Name"
        }
        alertController.addTextField { (lessonTypeTxtField) in
            lessonTypeTxtField.placeholder = "Lesson Type: iOS | Android"
        }
        
        let defaultAction = UIAlertAction(title: actionType.uppercased(), style: .default) { (action) in
            
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .default) { (action) in
            
        }
        
        alertController.addAction(defaultAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true)
    }

}
