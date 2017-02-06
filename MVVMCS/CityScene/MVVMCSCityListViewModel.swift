//
//  MVVMCSCityListViewModel.swift
//  MVVMCS
//
//  Created by Alex Hsieh on 27/1/17.
//  Copyright © 2017 Alex. All rights reserved.
//

import Foundation
import UIKit

protocol MVVMCSCityListViewModelDelegate: class
{
    func selectCity(viewController: UIViewController, city: City)
}

struct MVVMCSCityListViewModel {
    var delegate: MVVMCSCityListViewModelDelegate?
    weak var viewController: MVVMCSCityListViewController!
    var source = [String]()
    
    init() {
        for city in cities {
            source.append(city.name)
        }
    }
    
    func selectRow(row: NSInteger) {
        delegate?.selectCity(viewController: viewController, city: cities[row])
    }
    
    fileprivate var cities: [City] {
        get {
            return Cities().cities()
        }
    }
}
