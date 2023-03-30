//
//  Calories.swift
//  SpoonacularApp
//
//  Created by Natalia Goyes on 29/03/23.
//

import Foundation

struct Nutrition {
    
    var composition : CaloricBreakdown? = CaloricBreakdown()
    
    enum CodingKeys: String, CodingKey {
        case composition = "caloricBreakdown"
    }
}
