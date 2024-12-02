//
//  ViewController.swift
//  ToDoList
//
//  Created by Олег Спиридонов on 02.12.2024.
//

import UIKit

protocol MainScreenViewProtocol: AnyObject {
    func reloadData()
    func createNewTask()
    func editTask(task: Todo)
    func deleteTask(task: Todo)
}

class MainScreenViewController: UIViewController {
    
    // MARK: - Private Properties
    
    private let tasksTableView = UITableView()
    private let searchController = UISearchController(searchResultsController: nil)
    private let lowerBar = UIView()
    private let newTaskButton = UIBarButtonItem(barButtonSystemItem: .add, target: nil, action: nil)
    
    // MARK: - Public Properties
    
    var presenter: MainScreenPresenterProtocol?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        presenter?.viewDidLoaded()
    }
    
    // MARK: - Private Methods
    
    private func setupViews() {
        view.backgroundColor = .black
        setupNavBar()
        setupSearchController()
        setupLowerBar()
        setupTaskTableView()
    }
    
    private func setupNavBar() {
        self.title = "Задачи"
        navigationController?.navigationBar.prefersLargeTitles = true
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .black
        appearance.largeTitleTextAttributes = [
            .foregroundColor: UIColor.white,
            .font: UIFont.boldSystemFont(ofSize: 34)
        ]
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.tintColor = .white
    }
    
    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
    }
    
    private func setupLowerBar() {
        lowerBar.backgroundColor = .gray
        view.addSubview(lowerBar)
        lowerBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            lowerBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            lowerBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            lowerBar.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            lowerBar.heightAnchor.constraint(equalToConstant: 83)
        ])
    }
    
    private func setupTaskTableView() {
        tasksTableView.delegate = self
        tasksTableView.dataSource = self
        view.addSubview(tasksTableView)
        tasksTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tasksTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tasksTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tasksTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tasksTableView.bottomAnchor.constraint(equalTo: lowerBar.topAnchor)
        ])
    }
    
    // MARK: - Public Methods
    // MARK: - Private Actions
    // MARK: - Public Actions
    
}

// MARK: - MainScreenViewControllerProtocol

extension MainScreenViewController: MainScreenViewProtocol {
    
    func reloadData() {
        tasksTableView.reloadData()
    }
    
    func createNewTask() {
        
    }
    
    func editTask(task: Todo) {
        
    }
    
    func deleteTask(task: Todo) {
        
    }
}

// MARK: - UITableViewDataSource

extension MainScreenViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.tasks?.todos.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let presenter else { return UITableViewCell()}
        guard let tasks = presenter.tasks else { return UITableViewCell()}
        let cell = MainScreenTableViewCell(todo: tasks.todos[indexPath.row])
        return cell
    }
}

// MARK: - UITableViewDelegate

extension MainScreenViewController: UITableViewDelegate {
    
}

// MARK: - UISearchResultsUpdating

extension MainScreenViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        
    }
}
