//
//  TableViewController.swift
//  toDOListHomeWork
//
//  Created by Ернат on 07.05.2023.
//

import UIKit

class TableViewController: UITableViewController {
    
    var arrayTask: [TaskItem] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        }
    override func viewWillAppear(_ animated: Bool)  {
        let defaults = UserDefaults.standard
        
        do {
            if let data = defaults.data(forKey: "taskItemArray") {
                let array = try JSONDecoder().decode([TaskItem].self, from: data)
               
                arrayTask = array
            }
        } catch {
            print("unable to encode \(error)")
        }

        tableView.reloadData()
    }
    
    func saveTask() {
        let defaults = UserDefaults.standard
        
        do {
       
                let encodedata = try JSONEncoder().encode(arrayTask)
                
                defaults.set(encodedata, forKey: "taskItemArray")
        } catch {
            print("unable to encode \(error)")
        }
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayTask.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init(style: .subtitle, reuseIdentifier: "Cell")
        
        cell.textLabel?.text = arrayTask[indexPath.row].name
        cell.detailTextLabel?.text = arrayTask[indexPath.row].description
        
        if arrayTask[indexPath.row].isComplate {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        arrayTask[indexPath.row].isComplate.toggle()
        
        tableView.reloadData()
        
        saveTask()
    }
  
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            arrayTask.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            saveTask()
        } else if editingStyle == .insert {
           
        }    
    }
  
}
