//
//  ContainerViewController.swift
//  SpaceX
//
//  Created by Kairat Yelubay on 22.07.2022.
//

import UIKit

class RocketPageViewController: UIPageViewController {
    
    let initialPage = 0
    
    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: navigationOrientation, options: options)
        
        view.backgroundColor = .black
        dataSource = self
        delegate = self
        setViewControllers([RocketInfoViewController(rocketId: initialPage)], direction: .forward, animated: false)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension RocketPageViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewController = viewController as? RocketInfoViewController else { return nil }
        
        let currentIndex = viewController.rocketId
        if currentIndex != 0 {
            return RocketInfoViewController(rocketId: currentIndex - 1)
        }
        
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewController = viewController as? RocketInfoViewController else { return nil }
        
        let currentIndex = viewController.rocketId
        if currentIndex != 3 {
            return RocketInfoViewController(rocketId: currentIndex + 1)
        }
        
        return nil
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return 4
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
}
