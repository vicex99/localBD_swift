//
//  TaskVC.swift
//  Agenda
//
//  Created by VICTOR ALVAREZ LANTARON on 10/12/18.
//  Copyright © 2018 victorSL. All rights reserved.
//

import UIKit

class TaskVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    internal var tasks: [Task]!
    internal var repository: LocalTaskRepository!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.repository = LocalTaskRepository()
        self.tasks = self.repository.getAll()
        
        title = "TASKS"
    
        registerCell()
        
        let addBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addPressed))
        
        navigationItem.rightBarButtonItem = addBarButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIView.animate(withDuration: 0.8){
            self.view.backgroundColor =
            UIColor.white.withAlphaComponent(0.8)
        }
    }
    
    @objc internal func addPressed () {
        let addVC = AddViewController(repository)
        addVC.delegate = self
        addVC.modalTransitionStyle = .coverVertical
        addVC.modalPresentationStyle = .overCurrentContext
       
        // animacion de transicion
        UIView.animate(withDuration: 0.4, animations: {
            self.view.backgroundColor =
                UIColor.white.withAlphaComponent(0.0)
        })
         present(addVC, animated: true, completion: nil)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    internal func registerCell(){
        let identifier = "TaskCell"
        let nib = UINib(nibName: identifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: identifier)
    }
}

extension TaskVC : UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tasks[indexPath.row].isDone = !tasks[indexPath.row].isDone
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TaskCell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath) as! TaskCell
        
        let task = tasks[indexPath.row]
        cell.lblName.text = task.toDo
        cell.checkBoxImg.isHidden = !task.isDone
        
        return cell
    }
    internal func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle , forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let taskToDelete = tasks[indexPath.row]
            if repository.delete(a: taskToDelete){
                tasks.remove(at: indexPath.row)
                tableView.beginUpdates()
                tableView.deleteRows(at: [indexPath], with: .automatic)
                tableView.endUpdates()
            }
        }
    }
}

extension TaskVC: AddViewControllerDelegate {
    func addViewController(_ vc:AddViewController, didEditTask task: Task) {
        vc.dismiss(animated: true) {
            self.repository = LocalTaskRepository()
            self.tasks = self.repository.getAll()
            self.tableView.reloadData()
        }
    }
}
