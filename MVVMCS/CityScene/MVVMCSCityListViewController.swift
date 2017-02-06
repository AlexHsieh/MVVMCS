//
//  MVVMCSCityListViewController.swift
//  MVVMCS
//
//  Created by Alex Hsieh on 27/1/17.
//  Copyright © 2017 Alex. All rights reserved.
//

import UIKit

class MVVMCSCityListViewController: UITableViewController, Coordinated {
    var coordinationDelegate: CoordinationDelegate?
    var viewModel: MVVMCSCityListViewModel?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }

}

extension MVVMCSCityListViewController
{
    override func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if let viewModel = viewModel {
            return viewModel.source.count
        }
        
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell")
        if cell == nil {
            cell = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: "ItemCell")
        }
        cell!.textLabel?.text = viewModel?.source[indexPath.row]
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        viewModel?.selectRow(row: indexPath.row)
    }
}

