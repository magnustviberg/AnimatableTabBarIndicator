//
//  RootController.swift
//  CustomTabbarExample
//
//  Created by Magnus Tviberg on 21/04/2021.
//

import UIKit

class RootController: UITabBarController {
    
    // MARK: - Private properties
    private let layerGradient = CAGradientLayer()
    
    private var indicatorView: UIView = {
        let view = UIView()
        let height: CGFloat = 4
        view.clipsToBounds = true
        view.layer.cornerRadius = height / 2
        view.frame.size.width = 20
        view.frame.size.height = height
        view.backgroundColor = .white
        return view
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addGradientToTabbar()
        setupTabbar()
        addMockTabs(numberOfTabs: 4)
        addIndicatorView()
        self.delegate = self
        
    }
}

// MARK: - Private methodes
private extension RootController {
    
    func setupTabbar() {
        tabBar.isTranslucent = false
        tabBar.tintColor = .white
        tabBar.unselectedItemTintColor = UIColor.white.withAlphaComponent(0.5)
    }
    
    func addMockTabs(numberOfTabs: Int) {
        for i in 0..<numberOfTabs {
            let vc = UIViewController()
            let tabOneBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "info.circle"), selectedImage: UIImage(systemName: "info.circle.fill"))
            tabOneBarItem.tag = i // must be the index of the item
            vc.tabBarItem = tabOneBarItem
            if viewControllers == nil {
                self.viewControllers = [vc]
            } else {
                self.viewControllers?.append(vc)
            }
        }
    }
    
    func addGradientToTabbar() {
        layerGradient.colors = [UIColor(red: 43/255, green: 157/255, blue: 85/255, alpha: 1).cgColor,
                                UIColor(red: 30/255, green: 140/255, blue: 70/255, alpha: 1).cgColor]
        layerGradient.startPoint = CGPoint(x: 0, y: 1)
        layerGradient.endPoint = CGPoint(x: 1, y: 0)
        layerGradient.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
        tabBar.layer.addSublayer(layerGradient)
    }
    
    func addIndicatorView() {
        guard let numberOfTabs = tabBar.items?.count else { return }
        indicatorView.center.x =  tabBar.frame.width / CGFloat(numberOfTabs) / 2
        tabBar.addSubview(indicatorView)
    }
}

// MARK: - UITabBarControllerDelegate
extension RootController: UITabBarControllerDelegate {
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        guard let numberOfTabs = tabBar.items?.count else { return }
        UIView.animate(withDuration: 0.3) {
            let tabBarWidth = tabBar.frame.width
            let itemWidth = tabBarWidth / CGFloat(numberOfTabs)
            // move indicatorView to center of selected item
            self.indicatorView.center.x = itemWidth / 2 + (itemWidth * CGFloat(item.tag))
        }
    }
    
}
