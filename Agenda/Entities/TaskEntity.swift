//
//  TaskEntity.swift
//  Agenda
//
//  Created by VICTOR ALVAREZ LANTARON on 10/12/18.
//  Copyright © 2018 victorSL. All rights reserved.
//

import UIKit
import RealmSwift

class TaskEntity: Object {
    @objc dynamic var id = ""
    @objc dynamic var isDone = false
    @objc dynamic var toDo = ""
    
    convenience init(id: String, toDo: String, isDone: Bool){
        self.init()
        self.id = id
        self.isDone = isDone
        self.toDo = toDo
    }
    
    
    // para decir cual es el nombre de la variable que va a ser clave primaria
    override static func primaryKey() -> String? {
        return "id"
    }

    func taskModel() -> Task {
        let model = Task()
        model.id = id
        model.isDone = isDone
        model.toDo = toDo
        return model
    }
}
