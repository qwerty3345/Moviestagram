//
//  SearchController.swift
//  Moviestagram
//
//  Created by Mason Kim on 2023/02/04.
//

import UIKit

final class SearchController: UITableViewController {

    // MARK: - Properties
    private let viewModel = SearchViewModel()
    private let searchController = UISearchController(searchResultsController: nil)

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        configureTableView()
        configureSearchController()
        setNavigationBarTitle(with: "Search")

        bind(to: viewModel)
    }

    // MARK: - Helpers
    private func bind(to viewModel: SearchViewModel) {
        viewModel.searchedMovies.bind { [weak self] _ in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }

        viewModel.networkError.bind { [weak self] error in
            guard error != nil else { return }
            self?.showCannotSearchAlert()
        }
    }

    private func configureTableView() {
        tableView.registerCell(cellClass: SearchCell.self)
        tableView.dataSource = self
        
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

    let semaphore = DispatchSemaphore(value: 1)
    private func showCannotSearchAlert() {
        semaphore.wait()
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "검색에 실패했습니다.", message: "다른키워드로 검색 해 주세요", preferredStyle: .actionSheet)
            let action = UIAlertAction(title: "OK", style: .default) { _ in
                self.semaphore.signal()
            }
            alert.addAction(action)

            self.present(alert, animated: true, completion: nil)
        }
    }
}

// MARK: - UITableViewDataSource
extension SearchController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfMovies
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(cellClass: SearchCell.self, for: indexPath)

        if let movie = viewModel.movieForCell(at: indexPath) {
            cell.movie = movie
        }

        return cell
    }
}

// MARK: - UITableViewDelegate
extension SearchController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let movie = viewModel.searchedMovies.value[safe: indexPath.row] else { return }
        let detailVC = DetailController(movie: movie)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

// MARK: - UISearchBarDelegate
extension SearchController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchController.searchBar.text?.lowercased() else { return }
        viewModel.searchMovie(with: searchText)
    }
}
