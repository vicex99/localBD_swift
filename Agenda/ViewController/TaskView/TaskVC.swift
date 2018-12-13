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

    // se llama a este metodo cada vez que se carga la pantalla
    // en este caso para cargar los nuevos TASK en la lista
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tasks = repository.getAll()
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        repository = LocalTaskRepository()
        tasks = repository.getAll()
        
        title = "TASKS"
    
        registerCell()
        
        let addBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addPressed))
        
        navigationItem.rightBarButtonItem = addBarButtonItem
    }
    
    @objc internal func addPressed () {
        let addVC = AddViewController(repository)
        navigationController?.pushViewController(addVC, animated: true)
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
}
