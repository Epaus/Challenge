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
    private var selectedModel: NumberModel?
    private var currentlySelectedCell: MainTableViewCell?
    
    
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
        tableView.accessibilityIdentifier = ConstantText.master_tableview
        self.tableView.autoresizesSubviews = true
       
        NotificationCenter.default.addObserver(self, selector: #selector(showNetworkAlert), name: .noConnectivityNotification, object: nil)
        
        self.clearsSelectionOnViewWillAppear = true
        self.splitViewController?.maximumPrimaryColumnWidth = UIScreen.main.bounds.width/2.0
       
        self.viewModel.getData(completion: { results in
            DispatchQueue.main.async(execute: {
                self.tableView.reloadData()
            })
        })
    }
    
    override func viewWillLayoutSubviews() {
           super.viewWillLayoutSubviews()
           tableView.invalidateIntrinsicContentSize()
       }
    
    @objc func showNetworkAlert() {
        
        let tryAgainAction = UIAlertAction.init(title: "Try Again", style: .default, handler:{(alert: UIAlertAction!) in
            weak var wvm = self.viewModel
            wvm?.getData(completion: { (results) in
                DispatchQueue.main.async(execute: {
                    self.tableView.reloadData()
                })
            })
        })
        
        let actions = [tryAgainAction]
        
        let alert = AlertController.createAlert(title: "No Connectivity", message: "You are not connected to the internet.", actions: actions)
        
        self.splitViewController?.present(alert, animated: true)
    }
    
     
     override internal func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
         self.view.setNeedsLayout()
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
        
        var cell = tableView .dequeueReusableCell(withIdentifier: String(describing: MainTableViewCell.self)) as? MainTableViewCell
        if (cell == nil) {
            cell = MainTableViewCell.init(style: .default, reuseIdentifier: String(describing: MainTableViewCell.self))
        }
     
        let model = self.viewModel.list?[indexPath.row]
        
        cell?.model = model
        
        return cell ?? MainTableViewCell()
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
        
        if let currentCell = currentlySelectedCell {
            turnOff(cell: currentCell)
        }
        
        if let cell = tableView.cellForRow(at: indexPath) as? MainTableViewCell {
            cell.model?.isSelected = true
            currentlySelectedCell = cell
            
            if UIDevice.current.userInterfaceIdiom == .pad {
                setIpadHighlight(forCell: cell)
            }
        }
        
        selectedModel = self.viewModel.list?[indexPath.row]
        
        let storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc: DetailViewController = storyboard.instantiateViewController(withIdentifier: String(describing: DetailViewController.self)) as! DetailViewController
        vc.viewModel = self.viewModel
        if vc.currentViewControllerIndex != indexPath.row {
            updateCellHighlightAt(offIndex: vc.currentViewControllerIndex, onIndex: indexPath.row)
        }
        vc.currentViewControllerIndex = indexPath.row
        vc.delegate = self
        showDetailViewController(vc, sender: self)
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        guard let model = self.viewModel.list?[indexPath.row] else { return }
        model.isSelected = false
    }
    
    private func setIpadHighlight(forCell cell: MainTableViewCell) {
        if cell.model?.isSelected == true {
            cell.contentView.backgroundColor = .systemTeal
        } else {
            cell.contentView.backgroundColor = .white
        }
    }
    
     func turnOff(cell :MainTableViewCell) {
           cell.model?.isSelected = false
           cell.contentView.backgroundColor = .white
           cell.setNeedsLayout()
       }
       
       func turnOn(cell : MainTableViewCell) {
           cell.model?.isSelected = true
           cell.contentView.backgroundColor = .systemTeal
           cell.setNeedsLayout()
       }
    
}
extension ViewController: MasterViewUpdateProtocol {
    
    func updateCellHighlightAt(offIndex: Int, onIndex: Int) {
        
        if let cell = tableView.cellForRow(at: IndexPath.init(item: offIndex, section: 0)) as? MainTableViewCell {
            turnOff(cell: cell)
        }
        
        if let cell = tableView.cellForRow(at: IndexPath.init(item: onIndex, section: 0)) as? MainTableViewCell {
            turnOn(cell: cell)
            currentlySelectedCell = cell
        }
    }
}
