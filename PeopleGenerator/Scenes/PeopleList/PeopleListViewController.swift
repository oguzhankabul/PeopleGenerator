//
//  PeopleListViewController.swift
//  PeopleGenerator
//
//  Created by Oğuzhan Kabul on 14.06.2023.
//

import UIKit

// MARK: - PeopleListViewController
final class PeopleListViewController: BaseViewController<PeopleListViewModel> {
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.refreshControl = refreshControl
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "EmptyCell")
        return tableView
    }()
    
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshList), for: .valueChanged)
        return refreshControl
    }()
    
    private lazy var emptyStateView: SingleTextView = {
        let view = SingleTextView()
        let vm = SingleTextViewModel(tagText: "No one here :)")
        view.set(vm)
        view.isHidden = true
        return view
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.startAnimating()
        return activityIndicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupViewModelBindings()
        viewModel.fetchPeople()
    }
    
    override func setupViews() {
        super.setupViews()
        [tableView, activityIndicator].forEach({ view.addSubview( $0 )})
    }
    
    override func setupLayouts() {
        super.setupLayouts()
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func setupViewModelBindings() {
        viewModel.delegate = self
    }
    
    @objc private func refreshList() {
        viewModel.refreshPeople()
        tableView.reloadData()
    }
}

// MARK: - UITableViewDataSource
extension PeopleListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfPeople().isEmpty ? 1 : viewModel.numberOfPeople().numberOfPeople
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let person = viewModel.person(at: indexPath.row) else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "EmptyCell", for: indexPath)
            cell.contentView.addSubview(emptyStateView)
            NSLayoutConstraint.activate([
                emptyStateView.centerXAnchor.constraint(equalTo: cell.contentView.centerXAnchor),
                emptyStateView.centerYAnchor.constraint(equalTo: cell.contentView.centerYAnchor)
            ])
            viewModel.delegate?.showEmptyState()
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = "\(person.fullName) (\(person.id))"
        viewModel.delegate?.hideEmptyState()
        return cell
    }
}

// MARK: - UITableViewDelegate
extension PeopleListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == viewModel.numberOfPeople().numberOfPeople - 1 {
            viewModel.fetchPeople()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard (viewModel.person(at: indexPath.row) != nil) else {
            return tableView.bounds.height
        }
        return UITableView.automaticDimension
    }
}

// MARK: - UITableViewDelegate
extension PeopleListViewController: PeopleListViewModelDelegate {
    func showEmptyState() {
        if !activityIndicator.isAnimating {
            emptyStateView.isHidden = false
        }
    }
    
    func hideEmptyState() {
        emptyStateView.isHidden = true
    }
    
    func didFetch() {
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
        refreshControl.endRefreshing()
        tableView.reloadData()
    }
    
    func showError(message: String) {
        showErrorAlert(message: message)
    }
}

