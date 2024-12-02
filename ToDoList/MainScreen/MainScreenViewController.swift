//
//  ViewController.swift
//  ToDoList
//
//  Created by Олег Спиридонов on 02.12.2024.
//

import UIKit

protocol MainScreenViewControllerProtocol: AnyObject {
    func showTasks(tasks: [Todo])
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
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    // MARK: - Private Methods
    
    private func setupViews() {
        view.backgroundColor = .black
        setupNavBar()
        setupSearchController()
        setupLowerBar()
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
    
    // MARK: - Public Methods
    // MARK: - Private Actions
    // MARK: - Public Actions
    
}

// MARK: - MainScreenViewControllerProtocol

extension MainScreenViewController: MainScreenViewControllerProtocol {
    
    func showTasks(tasks: [Todo]) {
        
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
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
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
