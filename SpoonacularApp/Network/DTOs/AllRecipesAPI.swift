//
//  AllRecipesAPI.swift
//  SpoonacularApp
//
//  Created by Natalia Goyes on 28/03/23.
//

import Foundation

struct AllRecipesAPI: Codable {

  var results      : [RecipesAPI]? = []
  var offset       : Int?       = nil
  var number       : Int?       = nil
  var totalResults : Int?       = nil

  enum CodingKeys: String, CodingKey {

    case results      = "results"
    case offset       = "offset"
    case number       = "number"
    case totalResults = "totalResults"
  
  }

}
