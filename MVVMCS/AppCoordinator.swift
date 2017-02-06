//
//  AppCoordinator.swift
//  MVVMCS
//
//  Created by Alex Hsieh on 27/1/17.
//  Copyright © 2017 Alex. All rights reserved.
//

import UIKit

class AppCoordinator: Coordinator
{
    fileprivate let kHomeCoordinator: String  = "kHomeCoordinator"
    fileprivate let kCityCoordinator: String  = "kCityCoordinator"
    
    var window: UIWindow
    var coordinators = [String: Coordinator]()
    
    init(window: UIWindow)
    {
        self.window = window
        UIViewController.addCoordination()
    }
    
    func start()
    {
        goToHome()
    }
    
    func goToHome() {
        let homeCoordinator = MVVMCSHomeCoordinator(window: window)
        coordinators[kHomeCoordinator] = homeCoordinator
        homeCoordinator.delegate = self
        homeCoordinator.start()
    }

}

extension AppCoordinator: HandleSegueDelegate
{
    func handleSegue(segue: UIStoryboardSegue) {
        if segue.identifier == "showCityList" {
            let cityCoordinator = MVVMCSCityCoordinator(window: window)
            coordinators[kCityCoordinator] = cityCoordinator
            cityCoordinator.delegate = self
            cityCoordinator.handleSegue(segue: segue)
        }
    }
}


extension AppCoordinator: MVVMCSHomeCoordinatorDelegate
{
    func goToRandomCity()
    {
        let cityCoordinator = MVVMCSCityCoordinator(window: window)
        coordinators[kCityCoordinator] = cityCoordinator
        cityCoordinator.delegate = self
        cityCoordinator.presentRandomCity()
    }
}


extension AppCoordinator: MVVMCSCityCoordinatorDelegate
{

}



extension UIViewController {
    
    class func addCoordination() {
        DispatchQueue.once(token: "com.mvvmcs.test1") {
            let originalPerformSelector = #selector(UIViewController.prepare(for:sender:))
            let swizzledPerformSelector = #selector(swizzledPrepare(for:sender:))
            
            method_exchangeImplementations(class_getInstanceMethod(UIViewController.self, originalPerformSelector),
                                           class_getInstanceMethod(UIViewController.self, swizzledPerformSelector))
        }
    }
    
    func swizzledPrepare(for segue: UIStoryboardSegue,sender: Any?) {
        defer {
            self.swizzledPrepare(for: segue, sender: self)
        }
        
        guard let sourceViewController = segue.source as? Coordinated else {
            return
        }
        
        sourceViewController.coordinationDelegate?.prepareForSegue(segue: segue)

    }
}

public extension DispatchQueue {
    
    private static var _onceTracker = [String]()
    
    /**
     Executes a block of code, associated with a unique token, only once.  The code is thread safe and will
     only execute the code once even in the presence of multithreaded calls.
     
     - parameter token: A unique reverse DNS style name such as com.vectorform.<name> or a GUID
     - parameter block: Block to execute once
     */
    public class func once(token: String, block:(Void)->Void) {
        objc_sync_enter(self); defer { objc_sync_exit(self) }
        
        if _onceTracker.contains(token) {
            return
        }
        
        _onceTracker.append(token)
        block()
    }
}

