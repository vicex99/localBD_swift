//
//  AddViewController.swift
//  Agenda
//
//  Created by VICTOR ALVAREZ LANTARON on 10/12/18.
//  Copyright © 2018 victorSL. All rights reserved.
//

import UIKit

class AddViewController: UIViewController {

    @IBOutlet weak var txtNew: UITextField!
    internal weak var repository: LocalTaskRepository!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        repository = LocalTaskRepository()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func create() {
        let task = Task()
        task.id  = UUID().uuidString
        task.toDo = txtNew.text!
        task.isDone = false
        
        // volver a atrás
        if repository.create(a: task) {
            navigationController?.popViewController(animated: true)
        }
     }
}
