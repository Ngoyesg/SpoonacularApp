//
//  RecipeCell.swift
//  SpoonacularApp
//
//  Created by Natalia Goyes on 31/03/23.
//

import UIKit

/* Note: I chose not to do this method since storyboard is unresponsive. Better approach would be using this custom cell with programatically views.

protocol RecipeCellProtocol where Self: UITableViewCell {
    func setTitle(_ title: String?)
    func setImage(_ data: Data?)
    func toggleFavoriteStatus(to status: Bool)
}


class RecipeCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var recipeImage: UIImageView!
    
    @IBOutlet weak var favoriteStatus: UIImageView!
    
}

extension RecipeCell: RecipeCellProtocol {
    
    func setTitle(_ title: String?) {
        titleLabel.text = title ?? "No title found"
    }
    
    func setImage(_ data: Data?) {
        if let data = data {
            recipeImage.image = UIImage(data: data)
        } else {
            recipeImage.image = UIImage(systemName: "questionmark.square")
        }
    }
    
    func toggleFavoriteStatus(to status: Bool) {
         
        if status {
            favoriteStatus.isHidden = false
            favoriteStatus.image = UIImage(systemName: "star.circle.fill")
        } else {
            favoriteStatus.isHidden = true
        }
    }
    
}

*/