//
//  MainTabController.swift
//  Moviestagram
//
//  Created by Mason Kim on 2023/02/04.
//

import UIKit
import SnapKit

final class MainTabController: UITabBarController {

    // MARK: - Properties

    private let environment: AppEnvironment

    // MARK: - Lifecycle

    init(environment: AppEnvironment) {
        self.environment = environment
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

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
            viewController: FeedController(environment: environment))

        let searchNavigation = navigationController(
            unselected: UIImage(systemName: "magnifyingglass"),
            selected: UIImage(systemName: "magnifyingglass"),
            viewController: SearchController(environment: environment))

        let profileNavigation = navigationController(
            unselected: UIImage(systemName: "person.crop.circle"),
            selected: UIImage(systemName: "person.crop.circle.fill"),
            viewController: ProfileController(environment: environment))

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

// MARK: - UITabBarControllerDelegate
extension MainTabController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController,
                          shouldSelect viewController: UIViewController) -> Bool {
        let navigationVC = viewController as? UINavigationController
        let currentVC = navigationVC?.viewControllers.last

        if let viewController = currentVC as? UITableViewController,
           tabBarController.selectedViewController == viewController {

            viewController.tableView.scrollToRow(at: IndexPath(row: NSNotFound, section: 0), at: .top, animated: true)

            return false
        }

        return true
    }
}
