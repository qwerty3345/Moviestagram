//
//  SearchController.swift
//  Moviestagram
//
//  Created by Mason Kim on 2023/02/04.
//

import UIKit
import Combine

final class SearchController: UITableViewController {

    // MARK: - Properties

    private let environment: AppEnvironment
    private lazy var searchViewModel = SearchViewModel(
        movieRemoteRepository: environment.movieRemoteRepository
    )
    private var bag = Set<AnyCancellable>()

    // MARK: - UI Components

    private let searchController = UISearchController(searchResultsController: nil)

    // MARK: - Lifecycle

    init(environment: AppEnvironment) {
        self.environment = environment
        super.init(style: .plain)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configureTableView()
        configureSearchController()
        setNavigationBarTitle(with: "Search")

        bind(to: searchViewModel)
    }

    // MARK: - Helpers

    private func bind(to viewModel: SearchViewModel) {
        viewModel.$movies
            .sink { [weak self] _ in
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            }
            .store(in: &bag)

        viewModel.$isFailedToSearch
            .sink { [weak self] isFailed in
                guard isFailed else { return }
                self?.showCannotSearchAlert()
            }
            .store(in: &bag)
    }

    private func configureTableView() {
        tableView.registerCell(cellClass: SearchCell.self)
        tableView.dataSource = self

        setTableViewRowHeight()
        configureTapToHideSearchAction()
    }

    private func setTableViewRowHeight() {
        var rowHeight: CGFloat = 120
        rowHeight += 16
        tableView.rowHeight = 136
    }

    private func configureSearchController() {
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "영화 검색"
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
    }

    private func showCannotSearchAlert() {
        let alert = UIAlertController(title: "검색에 실패했습니다.", message: "다른키워드로 검색 해 주세요", preferredStyle: .actionSheet)
        let action = UIAlertAction(title: "OK", style: .default)
        alert.addAction(action)

        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            alert.dismiss(animated: true)
        }
    }

    private func configureTapToHideSearchAction() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(endEdittingSearchController))
        view.addGestureRecognizer(gesture)
    }

    @objc private func endEdittingSearchController() {
        searchController.searchBar.endEditing(true)
    }
}

// MARK: - UITableViewDataSource

extension SearchController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchViewModel.numberOfMovies
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(cellClass: SearchCell.self, for: indexPath)

        if let movie = searchViewModel.movieForCell(at: indexPath) {
            cell.viewModel = SearchCellViewModel(movie: movie)
        }

        return cell
    }
}

// MARK: - UITableViewDelegate

extension SearchController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let movie = searchViewModel.movieForCell(at: indexPath) else { return }
        let detailVC = DetailController(environment: environment, movie: movie)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

// MARK: - UISearchBarDelegate

extension SearchController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchController.searchBar.text?.lowercased() else { return }

        searchViewModel.searchTextSubject.send(searchText)
    }
}
