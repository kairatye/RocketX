//
//  ContainerViewController.swift
//  SpaceX
//
//  Created by Kairat Yelubay on 22.07.2022.
//

import UIKit

class RocketPageViewController: UIPageViewController {
    
//    private var rockets = [Rocket]()
//    var pages = [UIViewController]()
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        URLSession.shared.request(url: Constants.rocketsURL, expecting: [Rocket].self) { result in
//            switch result {
//            case .success(let rockets):
//                DispatchQueue.main.async {
//                    self.rockets = rockets
//                }
//            case .failure(let error):
//                print(error)
//            }
//        }
    }
}

extension RocketPageViewController {
//    func setup() {
//        dataSource = self
//        let page1 = RocketParametersViewController(rocket: rockets[0])
//        let page2 = RocketParametersViewController(rocket: rockets[1])
//        let page3 = RocketParametersViewController(rocket: rockets[2])
//        let page4 = RocketParametersViewController(rocket: rockets[3])
//
//        pages.append(page1)
//        pages.append(page2)
//        pages.append(page3)
//        pages.append(page4)
//
//        setViewControllers([pages[initialPage]], direction: .forward, animated: false)
//    }
}

extension RocketPageViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewController = viewController as? RocketInfoViewController else { return nil }
        
        let currentIndex = viewController.rocketId
        if currentIndex != 0 {
            return RocketInfoViewController(rocketId: currentIndex - 1)
        }
        
        return nil
//        guard let currentIndex = pages.firstIndex(of: viewController) else { return nil }
//
//        if currentIndex == 0 {
//            return pages.last
//        } else {
//            return pages[currentIndex - 1]
//        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewController = viewController as? RocketInfoViewController else { return nil }
        
        let currentIndex = viewController.rocketId
        if currentIndex != 3 {
            return RocketInfoViewController(rocketId: currentIndex + 1)
        }
        
        return nil
//        guard let currentIndex = pages.firstIndex(of: viewController) else { return nil }
//
//        if currentIndex < pages.count - 1 {
//            return pages[currentIndex + 1]
//        } else {
//            return pages.first
//        }
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return 4
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
}
