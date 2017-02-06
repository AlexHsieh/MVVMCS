//
//  MVVMCSCityDetailViewModel.swift
//  MVVMCS
//
//  Created by Alex Hsieh on 29/1/17.
//  Copyright © 2017 Alex. All rights reserved.
//

import Foundation

protocol MVVMCSCityDetailViewModelDelegate: class
{
}

struct MVVMCSCityDetailViewModel {
    weak var delegate: MVVMCSCityDetailViewModelDelegate?
    var name: String!
    var data: String!
    
    init(city: City) {
        self.name = city.name
        self.data = city.data
    }
    
}
