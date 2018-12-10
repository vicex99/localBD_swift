//
//  GeneralRepository.swift
//  Series
//
//  Created by VICTOR ALVAREZ LANTARON on 10/12/18.
//  Copyright © 2018 ALBERTO GURPEGUI RAMÓN. All rights reserved.
//

import Foundation

/**
 como una interfaz en Java
 
 */

protocol Repository {
    associatedtype T
    
    func getAll() -> [T]
    func get(identifier:String) -> T?
    func create(a: T) -> Bool
    func delete(a:T) ->Bool
}
