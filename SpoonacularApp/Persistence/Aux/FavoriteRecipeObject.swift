//
//  FavoriteRecipeObject.swift
//  SpoonacularApp
//
//  Created by Natalia Goyes on 28/03/23.
//

import Foundation
import RealmSwift

class FavoriteRecipeObject: Object {
    dynamic var id        : Int?
    dynamic var title     : String?
    dynamic var image     : String?
    
    override static func primaryKey() -> String? {
        return "id"
    }
}


