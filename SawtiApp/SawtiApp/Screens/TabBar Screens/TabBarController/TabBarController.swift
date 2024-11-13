//
//  TabBarController.swift
//  SawtiApp
//
//  Created by Ilmhona 10 on 11/11/24.
//

import UIKit

class TabBarController: UITabBarController {
    
    private let selectionIndicator: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "UI Green")
        view.layer.cornerRadius = 18
        return view
    }()
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let itemOffset: CGFloat = 25
        
        var tabBarFrame = tabBar.frame
        
        tabBarFrame.origin.y -= itemOffset / 2
        tabBarFrame.size.height += itemOffset
        tabBar.frame = tabBarFrame
        
        for tabBarSubView in tabBar.subviews {
            if let tabBarButton = tabBarSubView as? UIControl {
                var frame = tabBarButton.frame
                frame.origin.y += itemOffset / 2
                tabBarButton.frame = frame
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.addSubview(selectionIndicator)
        setupTabBarItems()
        setupTabs()
        
        
        guard let tabBarItems = tabBar.items, !tabBarItems.isEmpty else { return }
        delegate = self
    }
    
    func setupTabBarItems() {
        tabBar.tintColor = UIColor(named: "Brown")
        tabBar.backgroundColor = UIColor(named: "Cream")
        tabBar.unselectedItemTintColor = UIColor(named: "Brown")
        tabBar.layer.cornerRadius = 20
        tabBar.isTranslucent = true
    }
    
    func setupTabs() {
        let v1 = createNavigationController(with: UIImage(systemName: "house"), vc: MainViewController())
        let v2 = createNavigationController(with: UIImage(systemName: "book"), vc: LibraryViewController())
        let v3 = createNavigationController(with: UIImage(systemName: "magnifyingglass"), vc: SearchViewController())
        let v4 = createNavigationController(with: UIImage(systemName: "person.circle"), vc: ProfileViewController())
        
        self.setViewControllers([v1, v2, v3, v4], animated: true)
    }
    
    func createNavigationController(with image: UIImage?, vc: UIViewController) -> UINavigationController {
        let nc = UINavigationController(rootViewController: vc)
        nc.tabBarItem.image = image
        return nc
    }
    
    private func updateIndicatorPosition(for index: Int) {
        guard let tabBarItems = tabBar.items, index < tabBarItems.count else { return }
        
        let tabBarButtons = tabBar.subviews.filter { $0 is UIControl }
        guard index < tabBarButtons.count else { return }
        
        let targetTabBarButton = tabBarButtons[index]
        
        let itemWidth = targetTabBarButton.frame.width
        let targetX = targetTabBarButton.frame.origin.x
        let targetY = targetTabBarButton.center.y - 21
        
        if selectionIndicator.frame == .zero {
            selectionIndicator.frame = CGRect(x: targetX, y: targetY, width: itemWidth, height: 48)
        }
        
        UIView.animate(withDuration: 0.3) {
            self.selectionIndicator.frame = CGRect(x: targetX, y: targetY, width: itemWidth, height: 48)
        }
    }
}

// MARK: - UITabBarControllerDelegate

extension TabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        guard let index = viewControllers?.firstIndex(of: viewController) else { return }
        updateIndicatorPosition(for: index)
    }
}
