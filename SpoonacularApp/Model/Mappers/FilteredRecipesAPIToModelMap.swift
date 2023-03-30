//
//  FilteredRecipesAPIToModelMap.swift
//  SpoonacularApp
//
//  Created by Natalia Goyes on 30/03/23.
//

import Foundation

protocol FilteredRecipesAPIToModelMapProtocol: AnyObject {
    func convert(_ input: FilteredRecipesAPI) -> FilteredRecipesModel
}

class FilteredRecipesAPIToModelMap {
    func convert(_ input: FilteredRecipesAPI) -> FilteredRecipesModel {
        FilteredRecipesModel(type: input.type, recipes: input.resultstoObject, offset: input.offset, number: input.number, totalProducts: input.totalProducts)
    }
}

