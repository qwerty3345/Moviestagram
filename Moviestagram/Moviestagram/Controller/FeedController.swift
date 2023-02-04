//
//  FeedController.swift
//  Moviestagram
//
//  Created by Mason Kim on 2023/02/04.
//

import UIKit

class FeedController: UIViewController {
    // MARK: - Properties
    private let feedDataSource = FeedDataSource()
    private var movies: [Movie] = [] {
        didSet {
            feedDataSource.movies = movies
            DispatchQueue.main.async {
                self.feedTableView.reloadData()
            }
        }
    }

    // MARK: - UI Properties
    private let feedTableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        return tableView
    }()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPink

        MovieRepository.shared.fetchMovie { result in
            switch result {
            case .success(let movies):
                self.movies = movies
                print(movies.first)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }

        configureTableView()
    }

    // MARK: - Actions


    // MARK: - Helpers
    private func configureTableView() {
        feedTableView.registerCell(cellClass: FeedCell.self)
        feedTableView.dataSource = feedDataSource

        view.addSubview(feedTableView)
        feedTableView.fillSuperview()

        setTableViewRowHeight()
    }

    private func setTableViewRowHeight() {
        var rowHeight = view.frame.width + 8 + 40 + 8
        rowHeight += 50
        rowHeight += 60
        feedTableView.rowHeight = rowHeight
    }
}
