//
//  ListViewController.swift
//  reMIND
//
//  Created by Juan Manuel Jimenez Sanchez on 29/01/17.
//  Copyright © 2017 Juan Manuel Jimenez Sanchez. All rights reserved.
//

import UIKit

class ListViewController: UITableViewController {
    
    var taskManager = TaskManager.sharedInstance
    
    @IBAction func addTask(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: "New Task", message: "Task name", preferredStyle: .alert)
        alertController.addTextField(configurationHandler: nil)
        
        let alertAction = UIAlertAction(title: "Save", style: .default) { (alertAction) in
            if let textFieldText = alertController.textFields?.first?.text {
                self.taskManager.tasks.append(["title":textFieldText])
                self.tableView.reloadData()
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(alertAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailSegue" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let destinationVC = segue.destination as! IconsViewController
                let selectedTask = self.taskManager.tasks[indexPath.row]
                destinationVC.headerTitleString = selectedTask["title"]
                destinationVC.selectedTask = indexPath.row
            }
        }
    }
}

extension ListViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.taskManager.tasks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellIdentifier", for: indexPath) as! TaskCell
        
        let task = self.taskManager.tasks[indexPath.row]
        cell.lblTask.text = task["title"]
        if let image = task["icon"] {
            cell.imgTask.image = UIImage(named: image)
        } else {
            cell.imgTask.image = #imageLiteral(resourceName: "img_no_icon")
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let complete = UITableViewRowAction(style: .normal, title: "Complete") { (action, indexPath) in
            self.taskManager.tasks.remove(at: indexPath.row)
            self.tableView.reloadData()
        }
        
        complete.backgroundColor = #colorLiteral(red: 0.8, green: 0.9725490196, blue: 0.9529411765, alpha: 1)
        
        return [complete]
    }
}
