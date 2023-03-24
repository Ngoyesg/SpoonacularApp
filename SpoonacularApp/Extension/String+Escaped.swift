//
//  String+Escaped.swift
//  SpoonacularApp
//
//  Created by Natalia Goyes on 23/03/23.
//

import Foundation

extension String {
    
    func escaped() -> String {
        self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? self
    }
}


