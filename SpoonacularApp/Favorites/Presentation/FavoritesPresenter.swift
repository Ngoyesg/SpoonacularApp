//
//  FavoritesPresenter.swift
//  SpoonacularApp
//
//  Created by Natalia Goyes on 30/03/23.
//

import Foundation

protocol FavoritesPresenterProtocol: AnyObject {
    func setController(_ viewController: FavoritesTableViewControllerProtocol?)
}

class FavoritesPresenter {
    
    weak var controller: FavoritesTableViewControllerProtocol?

}

extension FavoritesPresenter: FavoritesPresenterProtocol {
    
    func setController(_ viewController: FavoritesTableViewControllerProtocol?) {
        self.controller = viewController
    }
    
}
