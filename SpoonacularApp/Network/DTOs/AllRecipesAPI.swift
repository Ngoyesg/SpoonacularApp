//
//  AllRecipesAPI.swift
//  SpoonacularApp
//
//  Created by Natalia Goyes on 28/03/23.
//

import Foundation

struct AllRecipesAPI: Codable, DecodableAPIResponse {

    let results: [RecipesAPI]?
    let offset: Int?
    let number: Int?
    let totalResults : Int?
    let message: String?
    let status: String?
    let code: Int?
}

extension AllRecipesAPI {
    var resultstoObject: [Recipe]? {
        results?.map({ eachRecipe in
            eachRecipe.toObject
        })
    }
}
