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
                do {
                    let realm = try! Realm()
                    if let entity = realm.objects(TaskEntity.self).filter("id == %@",identifier).first {
                        let model = entity.taskModel()
                        return model
                    }
        
                }
        return nil
    }
    
    func create(a: Task) -> Bool {
        do {
            let realm = try! Realm()
            let entity = TaskEntity(id: a.id, toDo: a.toDo, isDone: a.isDone)
            
            try realm.write {
                // El metodo update: true indica que si encuentra uno igual lo replaza
                realm.add(entity, update: true)
            }
            
        } catch {
            return false
        }
        return true
    }
    
    func delete(a:Task) ->Bool {
        do{
            let realm = try Realm()
            try realm.write {
                let entryToDelete = realm.objects(TaskEntity.self).filter("id == %@", a.id)
                realm.delete(entryToDelete)
            }
        }
        catch {
            return false
        }
        
        return true
    }
    
    func update(a: Task) -> Bool {
        return create(a: a)
    }
    
}
