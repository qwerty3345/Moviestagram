//
//  MainTabController.swift
//  Moviestagram
//
//  Created by Mason Kim on 2023/02/04.
//

import UIKit

final class MainTabController: UITabBarController {

    // MARK: - Properties


    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewControllers()

        for family in UIFont.familyNames.sorted() {
            let names = UIFont.fontNames(forFamilyName: family)
            print("Family: \(family) Font names: \(names)")
        }
    }

    // MARK: - Actions


    // MARK: - Helpers
    private func configureViewControllers() {
        tabBar.tintColor = appColor
        let feedNavigation = navigationController(unselected: UIImage(systemName: "film.stack"),
                                                  selected: UIImage(systemName: "film.stack.fill"),
                                                  viewController: FeedController())
        let searchNavigation = navigationController(unselected: UIImage(systemName: "magnifyingglass"),
                                                    selected: UIImage(systemName: "magnifyingglass"),
                                                    viewController: SearchController())
        let layout = UICollectionViewFlowLayout()
        let profileNavigation = navigationController(unselected: UIImage(systemName: "person.crop.circle"),
                                                     selected: UIImage(systemName: "person.crop.circle.fill"),
                                                     viewController: ProfileController(collectionViewLayout: layout))

        viewControllers = [feedNavigation, searchNavigation, profileNavigation]

    }

    private func navigationController(unselected: UIImage?, selected: UIImage?,
                                      viewController: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: viewController)
        nav.tabBarItem.image = unselected
        nav.tabBarItem.selectedImage = selected
        nav.navigationBar.tintColor = appColor
        return nav
    }
}
