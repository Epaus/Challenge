//
//  DetailViewController.swift
//  Challenge
//
//  Created by Estelle Paus on 8/27/20.
//  Copyright © 2020 Paus Productions. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    // what he calls ViewController

  
    @IBOutlet weak var contentView: UIView!
    
    var viewModel: ViewModel?
    var currentViewControllerIndex: Int = 0
    
    override func viewDidLoad() {

       configurePageViewController()
    }
    
    func configurePageViewController() {
        let storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let pageViewController: CustomPageViewController = storyboard.instantiateViewController(withIdentifier: String(describing: CustomPageViewController.self)) as! CustomPageViewController
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
        if index >= vm.listCount() || index == 0 {
            return nil
        }
        
        let storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        guard let dataViewController: DataViewController = storyboard.instantiateViewController(withIdentifier: String(describing: DataViewController.self)) as? DataViewController else { return nil }
        
        dataViewController.model = vm.list?[index]
        return dataViewController
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
        guard var currentIndex = detailViewController?.index else { return nil }
        currentViewControllerIndex = currentIndex
        if currentIndex == 0 {
            return nil
        }
        currentIndex -= 1
        return detailViewControllerAt(index: currentIndex)
        
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let detailViewController = viewController as? DataViewController
        guard var currentIndex = detailViewController?.index else { return nil }
        currentViewControllerIndex = currentIndex
        if currentIndex >= viewModel?.listCount() ?? 0  {
            return nil
        }
        currentIndex += 1
        return detailViewControllerAt(index: currentIndex)
    }
    
}


