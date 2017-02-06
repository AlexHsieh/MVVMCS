//
//  MVVMCSCityCoordinator.swift
//  MVVMCS
//
//  Created by Alex Hsieh on 27/1/17.
//  Copyright © 2017 Alex. All rights reserved.
//

import UIKit

protocol MVVMCSCityCoordinatorDelegate: HandleSegueDelegate {
    
}

class MVVMCSCityCoordinator: Coordinator {
    
    var window: UIWindow
    weak var delegate: MVVMCSCityCoordinatorDelegate?
    
    var selectedCity: City?
    
    init(window: UIWindow)
    {
        self.window = window
    }
    
    func start()
    {
        let storyboard = UIStoryboard(name: "City", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "list") as? MVVMCSCityListViewController {
            var viewModel =  MVVMCSCityListViewModel()
            viewModel.delegate = self
            viewModel.viewController = vc
            vc.viewModel = viewModel
            vc.coordinationDelegate = self
            let nav = UINavigationController.init(rootViewController: vc)
            window.rootViewController = nav
        }
    }
    
    func presentRandomCity() {
        let storyboard = UIStoryboard(name: "City", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "detail") as? MVVMCSCityDetailViewController,
           let nav = window.rootViewController
        {
            let viewModel =  MVVMCSCityDetailViewModel.init(city: Cities().randomCity())
            vc.viewModel = viewModel
            vc.coordinationDelegate = self
            let cityDetailNav = UINavigationController.init(rootViewController: vc)
            nav.present(cityDetailNav, animated: true, completion: nil)
        }
    }
}

extension MVVMCSCityCoordinator: HandleSegueDelegate {
    func handleSegue(segue: UIStoryboardSegue) {
        if segue.identifier == "showCityList" {
            let vc = segue.destination as! MVVMCSCityListViewController
            var viewModel =  MVVMCSCityListViewModel.init()
            viewModel.viewController = vc
            viewModel.delegate = self
            vc.coordinationDelegate = self
            vc.viewModel = viewModel
        }
    }
}

extension MVVMCSCityCoordinator: CoordinationDelegate {
    func prepareForSegue(segue: UIStoryboardSegue) {
        if segue.identifier == "showDetail" {
            let dest = segue.destination as! MVVMCSCityDetailViewController
            var viewModel = MVVMCSCityDetailViewModel.init(city: selectedCity!)
            dest.viewModel = viewModel
            viewModel.delegate = self
            dest.coordinationDelegate = self
        }
    }    
}

extension MVVMCSCityCoordinator: MVVMCSCityListViewModelDelegate {
    func selectCity(viewController: UIViewController , city: City) {
        selectedCity = city
        viewController.performSegue(withIdentifier: "showDetail", sender: viewController)
    }
}

extension MVVMCSCityCoordinator: MVVMCSCityDetailViewModelDelegate {
    
}
