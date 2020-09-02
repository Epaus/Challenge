//
//  DetailViewController.swift
//  Challenge
//
//  Created by Estelle Paus on 8/27/20.
//  Copyright © 2020 Paus Productions. All rights reserved.
//

import UIKit

protocol MasterViewUpdateProtocol {
    func updateCellHighlightAt(offIndex: Int, onIndex: Int)
}

class DetailViewController: UIViewController {
    
    var delegate: MasterViewUpdateProtocol?
    var navigationBar: UINavigationBar?
    
    
    @IBOutlet weak var contentView: UIView!
    
    var viewModel: ViewModel?
    var currentViewControllerIndex: Int = 0
    
    override func viewDidLoad() {
        configureNavigationBar()
        configurePageViewController()
    }
    
    func configurePageViewController() {
        let storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let pageViewController: UIPageViewController = storyboard.instantiateViewController(withIdentifier: String(describing: UIPageViewController.self)) as! UIPageViewController
        pageViewController.delegate = self
        pageViewController.dataSource = self
        addChild(pageViewController)
        pageViewController.didMove(toParent: self)
        contentView.addSubview(pageViewController.view)
        
        pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: pageViewController.view.safeAreaLayoutGuide.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: pageViewController.view.safeAreaLayoutGuide.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: pageViewController.view.safeAreaLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: pageViewController.view.safeAreaLayoutGuide.trailingAnchor)
        ])
        
        guard let startingViewController = detailViewControllerAt(index: self.currentViewControllerIndex) else { return }
        
        pageViewController.setViewControllers([startingViewController], direction: .forward, animated: true, completion: nil)
    }
    
    func detailViewControllerAt(index: Int) -> DataViewController? {
        
        guard let vm = viewModel else { return nil }
        if index >= vm.listCount() || index < 0 {
            return nil
        }
        
        let storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        guard let dataViewController: DataViewController = storyboard.instantiateViewController(withIdentifier: String(describing: DataViewController.self)) as? DataViewController else { return nil }
        
        dataViewController.model = vm.list?[index]
        dataViewController.index = index
        return dataViewController
    }
    
    // MARK:  NavigationBar
   
    private func configureNavigationBar() {
        navigationBar = UINavigationBar.init(frame: CGRect(x:0,y:0,width:UIScreen.main.bounds.width, height: 40.0))
        guard let navBar = navigationBar else { return }
        self.view.addSubview(navBar);
        navigationItem.leftBarButtonItem =
            splitViewController?.displayModeButtonItem
        navigationItem.leftBarButtonItem?.accessibilityIdentifier = "displayModeButtonItem"
        navigationItem.leftItemsSupplementBackButton = true
        
        navBar.setItems([navigationItem], animated: false);
    }
  
    
    private func detectOrientation() {
        if UIDevice.current.orientation.isLandscape {
            print("Landscape")
            navigationBar?.isHidden = true
        } else {
            print("Portrait")
            navigationBar?.isHidden = false
        }
    }
   
    
    override internal func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        detectOrientation()
    }
    
}

extension DetailViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return currentViewControllerIndex
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return viewModel?.listCount() ?? 0
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let detailViewController = viewController as? DataViewController
        guard let currentIndex = detailViewController?.index else { return nil }
        currentViewControllerIndex = currentIndex
       
        let nextIndex = currentIndex - 1
        if nextIndex == -1 {
           delegate?.updateCellHighlightAt(offIndex: currentViewControllerIndex + 1 , onIndex: currentViewControllerIndex)
            return nil
        }
        let nextController: DataViewController? = detailViewControllerAt(index: currentIndex)
        nextController?.model = viewModel?.list?[nextIndex]
        nextController?.index = nextIndex
        delegate?.updateCellHighlightAt(offIndex: currentViewControllerIndex + 1 , onIndex: currentViewControllerIndex)
       
        return nextController
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        let detailViewController = viewController as? DataViewController
        guard let currentIndex = detailViewController?.index else { return nil }
        currentViewControllerIndex = currentIndex
        if currentIndex >= viewModel?.listCount() ?? 0  {
            return nil
        }
        let nextIndex = currentIndex + 1
        let nextController: DataViewController? = detailViewControllerAt(index: nextIndex)
        nextController?.model = viewModel?.list?[nextIndex]
        nextController?.index = nextIndex
        
        delegate?.updateCellHighlightAt(offIndex: currentViewControllerIndex-1, onIndex: currentViewControllerIndex)
        
        return nextController
    }
}
