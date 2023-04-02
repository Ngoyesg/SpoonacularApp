//
//  FavoriteRecipeObject.swift
//  SpoonacularApp
//
//  Created by Natalia Goyes on 28/03/23.
//

import Foundation
import RealmSwift

class FavoriteRecipeObject: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var title: String = ""
    @objc dynamic var image: Data?

    override static func primaryKey() -> String? {
       return "id"
   }
}


