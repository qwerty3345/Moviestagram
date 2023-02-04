//
//  FeedController.swift
//  Moviestagram
//
//  Created by Mason Kim on 2023/02/04.
//

import UIKit

class FeedController: UIViewController {
    // MARK: - Properties
    private let movieTableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        return tableView
    }()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPink

        configureTableView()
    }

    // MARK: - Actions


    // MARK: - Helpers
    private func configureTableView() {
        movieTableView.registerCell(cellClass: FeedCell.self)
        movieTableView.dataSource = self

        view.addSubview(movieTableView)
        movieTableView.fillSuperview()

        setTableViewRowHeight()
    }

    private func setTableViewRowHeight() {
        var rowHeight = view.frame.width + 8 + 40 + 8
        rowHeight += 50
        rowHeight += 60
        movieTableView.rowHeight = rowHeight
    }
}

extension FeedController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(cellClass: FeedCell.self, for: indexPath)
        return cell
    }
}
