//
//  DetailsPresenter.swift
//  SpoonacularApp
//
//  Created by Natalia Goyes on 30/03/23.
//

import Foundation

protocol DetailsPresenterProtocol: AnyObject {
    func setController(_ viewController: DetailsViewControllerProtocol?)
}

class DetailsPresenter {
    
    weak var controller: DetailsViewControllerProtocol?
    
}

extension DetailsPresenter: DetailsPresenterProtocol {
    func setController(_ viewController: DetailsViewControllerProtocol?) {
        self.controller = viewController
    }
}
