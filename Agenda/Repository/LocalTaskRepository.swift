//
//  LocalTaskRepository.swift
//  Agenda
//
//  Created by VICTOR ALVAREZ LANTARON on 10/12/18.
//  Copyright © 2018 victorSL. All rights reserved.
//

import Foundation
import RealmSwift

class LocalTaskRepository: Repository{
    
    func getAll() -> [Task]{
        var tasks: [Task] = []
        
        do {
            let entities = try Realm().objects(TaskEntity.self).sorted(byKeyPath: "toDo", ascending: true)
            
            for entity in entities {
                let model = entity.taskModel()
                tasks.append(model)
            }
        }
        catch let error as NSError {
            print("ERROR getAll Tasks: ", error.description)
        }
        
        return tasks
    }
    
    func get(identifier:String) -> Task?{
        return nil
    }
    
    func create(a: Task) -> Bool{
        do {
            let realm = try Realm()
            let entity = TaskEntity(value: a)
            try realm.write {
                realm.add(entity, update: true)
            }
            
        } catch {
            return false
        }
        return true
    }
    
    func delete(a:Task) ->Bool{
        return false
    }
    
}
