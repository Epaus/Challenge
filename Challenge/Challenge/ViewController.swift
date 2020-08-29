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
}

// MARK: Table Datasource Functions
extension ViewController {
    public override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.listCount()
    }
    
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView .dequeueReusableCell(withIdentifier: ConstantText.cellId) as? MainTableViewCell
        if (cell == nil) {
            cell = MainTableViewCell.init(style: .default, reuseIdentifier: ConstantText.cellId)
        }
        let model = self.viewModel.list?[indexPath.row]
        cell?.model = model
        
        return cell ?? UITableViewCell()
    }
}
   

// MARK: TableView Delegate functions
extension ViewController {
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let cell = tableView.cellForRow(at: indexPath) as? MainTableViewCell {
            if UIDevice.current.userInterfaceIdiom == .pad {
                if cell.isSelected == true {
                    if cell.highlightedState == false {
                        cell.contentView.backgroundColor = .green
                        cell.highlightedState = true
                    }
                    else if cell.highlightedState == true {
                        cell.contentView.backgroundColor = .white
                        cell.highlightedState = false
                    }
                }
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? MainTableViewCell {
            cell.contentView.backgroundColor = UIColor.lightGray
        }
    }
}
