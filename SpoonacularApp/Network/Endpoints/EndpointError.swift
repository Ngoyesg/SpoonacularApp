//
//  EndpointError.swift
//  SpoonacularApp
//
//  Created by Natalia Goyes on 25/03/23.
//

import Foundation

enum EndpointError: Error {
    case invalidURL, invalidSearchBoundaries, emptySearch, invalidSearchID
}
