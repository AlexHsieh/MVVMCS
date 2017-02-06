//
//  MVVMCSCityDetailViewController.swift
//  MVVMCS
//
//  Created by Alex Hsieh on 28/1/17.
//  Copyright © 2017 Alex. All rights reserved.
//

import UIKit

class MVVMCSCityDetailViewController: UIViewController, Coordinated {
    var coordinationDelegate: CoordinationDelegate?
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dataLabel: UILabel!
    var viewModel: MVVMCSCityDetailViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = viewModel?.name
        dataLabel.text = viewModel?.data
        
        if (navigationController?.viewControllers.count)! == 1 {
            let closeButton = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(dismissFromParent))
            navigationItem.leftBarButtonItem = closeButton
        }
    }

    func dismissFromParent() {
        self.dismiss(animated: true, completion: nil)
    }

}
