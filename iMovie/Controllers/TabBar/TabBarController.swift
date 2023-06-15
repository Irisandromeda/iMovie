//
//  TabBarController.swift
//  iMovie
//
//  Created by Irisandromeda on 12.06.2023.
//

import UIKit
import FirebaseAuth

class TabBarController: UITabBarController {
    
    private var currentUser: User
    
    init(user: User) {
        self.currentUser = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabBar()
        print(currentUser.uid)
        print(currentUser.email!)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setTabBarLayer()
    }
    
    private func setupTabBar() {
        let searchViewController = SearchViewController(user: currentUser)
        let favoritesViewController = FavoritesViewController(nibName: "FavoritesViewController", bundle: nil)
        let profileViewController = ProfileViewController(nibName: "ProfileViewController", bundle: nil)
        
        viewControllers = [
            setupViewController(UINavigationController(rootViewController: searchViewController), title: "Search", image: UIImage(named: "search")!),
            setupViewController(UINavigationController(rootViewController: favoritesViewController), title: "Favorites", image: UIImage(named: "favorites")!),
            setupViewController(UINavigationController(rootViewController: profileViewController), title: "Profile", image: UIImage(named: "profile")!)
        ]
        
        tabBar.tintColor = UIColor(named: "defaultWhite")
    }
    
    private func setupViewController(_ viewController: UINavigationController, title: String, image: UIImage) -> UIViewController {
        viewController.tabBarItem.title = title
        viewController.tabBarItem.image = image
        
        return viewController
    }
    
    private func setTabBarLayer() {
        let positionX: CGFloat = 50
        let positionY: CGFloat = 12
        let width = tabBar.bounds.width - positionX * 2
        let height = tabBar.bounds.height + positionY * 2
        
        let roundLayer = CAShapeLayer()
        roundLayer.fillColor = UIColor(named: "labelColor")?.cgColor
        
        let bazierPath = UIBezierPath(roundedRect: CGRect(x: positionX, y: tabBar.bounds.minY - positionY, width: width, height: height), cornerRadius: height / 2)
        
        roundLayer.path = bazierPath.cgPath
        
        tabBar.layer.insertSublayer(roundLayer, at: 0)
        
        tabBar.itemWidth = width / 5
        tabBar.itemPositioning = .centered
    }
}
