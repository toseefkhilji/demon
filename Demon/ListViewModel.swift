//
//  ListViewModel.swift
//  Demon
//
//  Created by Jesús Manuel Ramos Juarez on 15/08/17.
//  Copyright © 2017 Jesús Manuel Ramos Juarez. All rights reserved.
//

import Foundation
import UIKit

protocol ListViewModel: BaseViewModel {
    
    associatedtype Item
    
    func setProgressVisibility(isProgressHidden: Bool, isEmptyListMessageHidden: Bool, isTableViewHidden: Bool)
    
    func endRefreshing()
    
    func displayItems(items: [Item])
}
