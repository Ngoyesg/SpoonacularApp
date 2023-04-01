//
//  FilteredRecipesAPIToModelMap.swift
//  SpoonacularApp
//
//  Created by Natalia Goyes on 30/03/23.
//

import Foundation

protocol FilteredRecipesAPIToModelMapProtocol: AnyObject {
    func convert(_ input: FilteredRecipesAPI) -> AllRecipesModel
}

class FilteredRecipesAPIToModelMap: FilteredRecipesAPIToModelMapProtocol {
    func convert(_ input: FilteredRecipesAPI) -> AllRecipesModel {
        AllRecipesModel(recipes: input.resultstoObject, offset: input.offset, number: input.number, totalResults: input.totalProducts)
    }
}

