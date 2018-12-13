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
    
    convenience init(_ repository:LocalTaskRepository!){
        self.init()
        self.repository = repository
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func create() {
        let task = Task()
        task.id  = UUID().uuidString
        task.toDo = txtNew.text!
        task.isDone = false
        repository.create(a: task)
        // volver a atrás
//        if  {
            navigationController?.popViewController(animated: true)
//        }
     }
}
