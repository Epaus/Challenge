//
//  ViewController.swift
//  Challenge
//
//  Created by Estelle Paus on 8/27/20.
//  Copyright © 2020 Paus Productions. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var viewModel: ViewModel
    private var detailViewController: DetailViewController?
    private var selectedModel: Model?
    
    
    
   
    
    // MARK: - Lifecycle
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    init(frame: CGRect, viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        self.viewModel = ViewModel()
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.viewModel.getData(completion: { results in
            DispatchQueue.main.async(execute: {
                self.tableView.reloadData()
            })
        })
    }
    
    

// MARK: Table Datasource Functions
    
    public override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.listCount()
    }
    
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView .dequeueReusableCell(withIdentifier: "mainCell")
        if (cell == nil) {
            cell = UITableViewCell.init(style: .default, reuseIdentifier: "mainCell")
        }
        let model = self.viewModel.list?[indexPath.row]
        cell?.textLabel?.text = model?.name
        return cell ?? UITableViewCell()
    }
    
    
}


