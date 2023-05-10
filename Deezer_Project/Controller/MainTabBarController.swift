//
//  MainTabBarController.swift
//  Deezer_Project
//
//  Created by Mert Altay on 10.05.2023.
//

import UIKit

class MainTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}
    // MARK: - HELPERS
extension MainTabBarController {
    private func setup() {
        viewControllers = [
            createViewController(rootViewController: MainViewController(), title: "Türler", imageName: "music.quarternote.3"),
            createViewController(rootViewController: FavoriteViewController(), title: "Favoriler", imageName: "heart")
        ]
    }
    private func createViewController(rootViewController: UIViewController, title: String, imageName: String) -> UINavigationController {
        rootViewController.title = title
        let appearance = UINavigationBarAppearance()
        appearance.configureWithDefaultBackground()
        let controller = UINavigationController(rootViewController: rootViewController)
        controller.navigationBar.prefersLargeTitles = true
        controller.navigationBar.compactAppearance = appearance
        controller.navigationBar.standardAppearance = appearance
        controller.navigationBar.scrollEdgeAppearance = appearance
        controller.navigationBar.compactScrollEdgeAppearance = appearance
        controller.tabBarItem.title = title
        controller.tabBarItem.image = UIImage(systemName: imageName)
        return controller
    }
    
}
