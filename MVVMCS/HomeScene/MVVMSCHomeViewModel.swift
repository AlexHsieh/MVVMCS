//
//  MVVMSCHomeViewModel.swift
//  MVVMCS
//
//  Created by Alex Hsieh on 27/1/17.
//  Copyright © 2017 Alex. All rights reserved.
//

import Foundation
import UIKit

protocol MVVMCSHomeViewModelDelegate: class
{
    func homeViewModelDidSelectGoToCityList(viewController: UIViewController)
    func homeViewModelDidSelectGoToRandomCity()
}

struct MVVMCSHomeViewModel
{
    weak var delegate: MVVMCSHomeViewModelDelegate?
    weak var viewController: MVVMCSHomeViewController?
    
    func didSelectGoToCityList(){
        delegate?.homeViewModelDidSelectGoToCityList(viewController: self.viewController!)
    }
    
    func didSelectGoToRandomCity(){
        delegate?.homeViewModelDidSelectGoToRandomCity()
    }
}

