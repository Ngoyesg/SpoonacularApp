//
//  AllRecipesAPIToModelMap.swift
//  SpoonacularApp
//
//  Created by Natalia Goyes on 30/03/23.
//

import Foundation

protocol AllRecipesAPIToModelMapProtocol: AnyObject {
    func convert(_ input: AllRecipesAPI) -> AllRecipesModel
}

class AllRecipesAPIToModelMap: AllRecipesAPIToModelMapProtocol {
    func convert(_ input: AllRecipesAPI) -> AllRecipesModel {
        AllRecipesModel(recipes: input.resultstoObject, offset: input.offset, number: input.number, totalResults: input.totalResults)
    }
}
