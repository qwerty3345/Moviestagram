//
//  SearchController.swift
//  Moviestagram
//
//  Created by Mason Kim on 2023/02/04.
//

import UIKit

final class SearchController: UITableViewController {

    // MARK: - Properties
    private var searchedMovies: [Movie] = []
    private let searchController = UISearchController(searchResultsController: nil)

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        configureTableView()
        configureSearchController()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        configureNavigationBarTitle(with: "Search")
    }

    // MARK: - API
    private func searchMovie(with keyword: String) {
        MovieRepository.shared.fetchMovie(with: [.search(keyword), .sortByLike]) { result in
            switch result {
            case .success(let movies):
                self.updateTableView(with: movies)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    // MARK: - Helpers
    private func configureTableView() {
        tableView.registerCell(cellClass: SearchCell.self)
        tableView.dataSource = self
        tableView.rowHeight = 80
        
        setTableViewRowHeight()
    }

    private func setTableViewRowHeight() {
        var rowHeight: CGFloat = 120
        rowHeight += 16
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = rowHeight
    }
    
    private func configureSearchController() {
        searchController.hidesNavigationBarDuringPresentation = false

        searchController.searchBar.placeholder = "영화 검색"
        navigationItem.searchController = searchController

        searchController.searchBar.delegate = self
    }

    private func updateTableView(with movies: [Movie]) {
        DispatchQueue.main.async {
            self.searchedMovies = movies
            self.tableView.reloadData(with: .transitionCrossDissolve)
        }
    }
}

// MARK: - UITableViewDataSource
extension SearchController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchedMovies.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(cellClass: SearchCell.self, for: indexPath)

        if let movie = searchedMovies[safe: indexPath.row] {
            cell.movie = movie
        }

        return cell
    }
}

// MARK: - UISearchBarDelegate
extension SearchController:  UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchController.searchBar.text?.lowercased() else { return }
        searchMovie(with: searchText)
    }
}
