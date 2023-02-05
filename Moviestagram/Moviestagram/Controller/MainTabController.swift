//
//  MainTabController.swift
//  Moviestagram
//
//  Created by Mason Kim on 2023/02/04.
//

import UIKit

final class MainTabController: UITabBarController {

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        configureViewControllers()
    }

    // MARK: - Helpers
    private func configureViewControllers() {
        tabBar.tintColor = appColor

        let feedNavigation = navigationController(
            unselected: UIImage(systemName: "film.stack"),
            selected: UIImage(systemName: "film.stack.fill"),
            viewController: FeedController())

        let searchNavigation = navigationController(
            unselected: UIImage(systemName: "magnifyingglass"),
            selected: UIImage(systemName: "magnifyingglass"),
            viewController: SearchController())

        let layout = UICollectionViewFlowLayout()
        let profileNavigation = navigationController(
            unselected: UIImage(systemName: "person.crop.circle"),
            selected: UIImage(systemName: "person.crop.circle.fill"),
            viewController: ProfileController(collectionViewLayout: layout))

        viewControllers = [feedNavigation, searchNavigation, profileNavigation]
    }

    private func navigationController(unselected: UIImage?,
                                      selected: UIImage?,
                                      viewController: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: viewController)
        nav.tabBarItem.image = unselected
        nav.tabBarItem.selectedImage = selected
        nav.navigationBar.tintColor = appColor
        return nav
    }
}

extension MainTabController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        let currentIndex = tabBarController.selectedIndex
        let currentViewController = tabBarController.viewControllers?[currentIndex]

        guard currentViewController == viewController else {
            return true
        }

        let navigationVC = viewController as? UINavigationController
        let rootVC = navigationVC?.viewControllers.last

        if let vc = rootVC as? UITableViewController {
            vc.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
        }

        return false
    }
}
