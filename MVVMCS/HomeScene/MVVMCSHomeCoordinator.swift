//
//  MVVMCSHomeCoordinator.swift
//  MVVMCS
//
//  Created by Alex Hsieh on 27/1/17.
//  Copyright © 2017 Alex. All rights reserved.
//

import UIKit

protocol MVVMCSHomeCoordinatorDelegate: HandleSegueDelegate {
    func goToRandomCity()
}

class MVVMCSHomeCoordinator: Coordinator {
    
    var window: UIWindow
    weak var delegate: MVVMCSHomeCoordinatorDelegate?
    
    init(window: UIWindow)
    {
        self.window = window
    }
    
    func start()
    {
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        if let nav = storyboard.instantiateInitialViewController() as? UINavigationController {
            let vc = nav.viewControllers.first as! MVVMCSHomeViewController
            var viewModel =  MVVMCSHomeViewModel()
            viewModel.delegate = self
            viewModel.viewController = vc
            vc.viewModel = viewModel
            vc.coordinationDelegate = self
            window.rootViewController = nav
        }
    }
}

extension MVVMCSHomeCoordinator: CoordinationDelegate {
    func prepareForSegue(segue: UIStoryboardSegue) {
        if segue.identifier == "showCityList" {
            delegate?.handleSegue(segue: segue)
        }
    }
}

extension MVVMCSHomeCoordinator: MVVMCSHomeViewModelDelegate {
    func homeViewModelDidSelectGoToCityList(viewController: UIViewController) {
        viewController.performSegue(withIdentifier: "showCityList", sender: viewController)
    }
    func homeViewModelDidSelectGoToRandomCity() {
        delegate?.goToRandomCity()
    }
}
