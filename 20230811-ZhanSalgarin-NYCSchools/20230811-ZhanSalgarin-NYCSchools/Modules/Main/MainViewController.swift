//
//  MainViewController.swift
//  20230811-ZhanSalgarin-NYCSchools
//
//  Created by zhanybek salgarin on 8/11/23.
//

import UIKit

private extension MainViewController {
    struct Layout {
        static let cellHeight: CGFloat = 100
    }
    
    struct Constant {
        static let title = "Schools"
        static let searchPlaceholder = "Search school name"
    }
}

final class MainViewController: UIViewController {
    
    private var viewModel: MainViewModelProtocol
    
    private let refreshControl = UIRefreshControl()
    
    private let searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = Constant.searchPlaceholder
        return searchController
    }()
    
    private var tableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = .systemCyan
        table.register(SchoolTableViewCell.self, forCellReuseIdentifier: SchoolTableViewCell.id)
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    init(viewModel: MainViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        bind()
        viewModel.fetchData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = Constant.title
    }
    
}

private extension MainViewController {
    
    func configure() {
        view.backgroundColor = .darkGray
        
        tableView.frame = view.bounds
        tableView.delegate = self
        tableView.dataSource = self
        tableView.refreshControl = refreshControl
        
        refreshControl.addTarget(self, action: #selector(update), for: .valueChanged)
        
        view.addSubview(tableView)
        setupSearchController()
    }
    
    func bind() {
        viewModel.didDataLoad = { [weak self] in
            self?.refreshControl.endRefreshing()
            self?.tableView.reloadData()
        }
        viewModel.didErrorOccur = { [weak self] error in
            // TODO: - Handle error properly via alert controller or pop off view
        }
    }
    
    @objc func update() {
        viewModel.fetchData()
    }
    
    func setupSearchController() {
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    func navigateToSchoolView(with schoolDBN: String) {
        let schoolDataService = SchoolDataService()
        let viewModel = SchoolDetailViewModel(schoolDBN: schoolDBN, schoolDataService: schoolDataService)
        let viewController = SchoolDetailViewController(viewModel: viewModel)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    // MARK: - Animation: a sprincle of glitter :)
    func animateCell(duration: Double, indexPath: IndexPath, cell: UITableViewCell) {
        cell.alpha = 0
        UIView.animate(withDuration: 0.1, delay: 0.001 * Double(indexPath.row), animations: {
            cell.alpha = 1
        })
    }
    
    
    // MARK: - Actions
    func didSelect(with schoolDBN: String) {
        self.navigateToSchoolView(with: schoolDBN)
    }
}

extension MainViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let _ = searchController.searchBar.text {
            // MARK: I would Implement search controller.
        }
    }
}

// MARK: - TableView
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.schools.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SchoolTableViewCell.id, for: indexPath) as? SchoolTableViewCell else {
            return UITableViewCell()
        }
        let countryRow = viewModel.schools[indexPath.row]
        cell.configure(with: countryRow)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Layout.cellHeight
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        animateCell(duration: 0, indexPath: indexPath, cell: cell)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelect(with: viewModel.schools[indexPath.row].dbn)
    }
}
