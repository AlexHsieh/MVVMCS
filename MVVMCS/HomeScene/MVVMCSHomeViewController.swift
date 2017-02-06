//
//  MVVMCSHomeViewController.swift
//  MVVMCS
//
//  Created by Alex Hsieh on 27/1/17.
//  Copyright © 2017 Alex. All rights reserved.
//

import Foundation


import UIKit

class MVVMCSHomeViewController: UIViewController, Coordinated
{
    @IBOutlet weak var pickCityButton: UIButton!
    @IBOutlet weak var randomPickCityButton: UIButton!
        
    var viewModel: MVVMCSHomeViewModel?
    var coordinationDelegate: CoordinationDelegate?
    
    override func viewDidLoad(){
    }
    
    @IBAction func pickCityButtonClicked(_ sender: Any) {
        viewModel?.didSelectGoToCityList()
    }
    
    @IBAction func randomPickButtonClicked(_ sender: Any) {
        viewModel?.didSelectGoToRandomCity()
    }
}
