//
//  AddViewController.swift
//  Agenda
//
//  Created by VICTOR ALVAREZ LANTARON on 10/12/18.
//  Copyright © 2018 victorSL. All rights reserved.
//

import UIKit

protocol AddViewControllerDelegate: class {
    func addViewController(_ vc: AddViewController, didEditTask: Task)
}

class AddViewController: UIViewController {
    
    @IBOutlet weak var txtNew: UITextField!
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var panelBackground: UIView!
    internal weak var repository: LocalTaskRepository!
    internal weak var delegate: AddViewControllerDelegate!
    
    
    
    convenience init(_ repository:LocalTaskRepository!){
        self.init()
        self.repository = repository
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnSave.layer.cornerRadius = 8.0
        btnSave.layer.masksToBounds = true
        
        panelBackground.layer.cornerRadius = 8.0
        panelBackground.layer.masksToBounds = true
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func create() {
        let task = Task()
        task.id  = UUID().uuidString
        task.toDo = txtNew.text!
        task.isDone = false
        
        // animacion de transicion
        UIView.animate(withDuration: 0.4, animations: {
                self.view.backgroundColor =
            UIColor.white.withAlphaComponent(0.0)
        }) { (bool) in
            if self.repository.create(a: task) {
                self.delegate?.addViewController(self, didEditTask: task)
            }
        }
     }
}

