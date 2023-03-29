//
//  DBAddManager.swift
//  SpoonacularApp
//
//  Created by Natalia Goyes on 29/03/23.
//

import Foundation

protocol DBAddManagerProtocol: AnyObject {
    func add<T: Persistable>(object: T) throws
}

class DBAddManager: DBManager, DBAddManagerProtocol{
    
    func add<T: Persistable>(object: T) throws {
        do {
            try realm.write{
                realm.add(object.managedObject())
            }
        } catch {
            throw DBManagerError.unableToAddObject
        }
    }
}
