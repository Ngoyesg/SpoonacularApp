//
//  AllRecipesAPI.swift
//  SpoonacularApp
//
//  Created by Natalia Goyes on 28/03/23.
//

import Foundation

struct AllRecipesAPI: Codable {

  var results      : [RecipiesResults]? = []
  var offset       : Int?       = nil
  var number       : Int?       = nil
  var totalResults : Int?       = nil

  enum CodingKeys: String, CodingKey {

    case results      = "results"
    case offset       = "offset"
    case number       = "number"
    case totalResults = "totalResults"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    results      = try values.decodeIfPresent([RecipiesResults].self , forKey: .results      )
    offset       = try values.decodeIfPresent(Int.self       , forKey: .offset       )
    number       = try values.decodeIfPresent(Int.self       , forKey: .number       )
    totalResults = try values.decodeIfPresent(Int.self       , forKey: .totalResults )
 
  }

  init() {

  }

}
