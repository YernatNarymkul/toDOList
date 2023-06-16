//
//  ViewController.swift
//  toDOListHomeWork
//
//  Created by Ернат on 07.05.2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var textField2: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func addTask(_ sender: Any) {
        let defaults = UserDefaults.standard
        
        let taskName = textField.text!
        let taskName2 = textField2.text!

        var newTask = TaskItem()
        
        newTask.name = taskName
        newTask.description = taskName2
        
        
        do {
            if let data = defaults.data(forKey: "taskItemArray") {
                var array = try JSONDecoder().decode([TaskItem].self, from: data)
                
                array.append(newTask)
                
                let encodedata = try JSONEncoder().encode(array)
                defaults.set(encodedata, forKey: "taskItemArray")
                
            } else {
                
                let encodedata = try JSONEncoder().encode([newTask])
                
                defaults.set(encodedata, forKey: "taskItemArray")
            }
            
        } catch {
            print("unable to encode \(error)")
        }

        
//        do {
//            if let data = defaults.data(forKey: "taskItemArray") {
//                var array = try JSONDecoder().decode([TaskItem].self, from: data)
//
//                array.append(newTask)
//
//                let encodedata = try JSONEncoder().encode(array)
//
//                defaults.set(encodedata, forKey: "taskItemArray")
//
//            } else {
//
//                let encodedata = try JSONEncoder().encode([newTask])
//
//                defaults.set(encodedata, forKey: "taskItemArray")
//            }
//
//        } catch {
//            print("unable to encode \(error)")
//        }

        textField.text = ""
        
        textField2.text = ""
    }
    
}

