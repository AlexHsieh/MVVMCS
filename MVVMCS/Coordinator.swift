//
//  Coordinator.swift
//  MVVMCS
//
//  Created by Alex Hsieh on 27/1/17.
//  Copyright © 2017 Alex. All rights reserved.
//

import UIKit

protocol Coordinator: class
{
    func start()
}

protocol HandleSegueDelegate: class {
    func handleSegue(segue: UIStoryboardSegue)
}

protocol CoordinationDelegate {
    func prepareForSegue(segue: UIStoryboardSegue)
}

protocol Coordinated {
    var coordinationDelegate: CoordinationDelegate? { get set }
}

