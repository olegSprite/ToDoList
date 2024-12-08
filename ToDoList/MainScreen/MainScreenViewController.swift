//
//  ViewController.swift
//  ToDoList
//
//  Created by Олег Спиридонов on 02.12.2024.
//

import UIKit

protocol MainScreenViewProtocol: AnyObject {
    func reloadData()
    func fetchNewData()
}

class MainScreenViewController: UIViewController {
    
    // MARK: - Private Properties
    
    private let tasksTableView = UITableView()
    private let searchController = UISearchController(searchResultsController: nil)
    private let lowerBar = UIView()
    private let taskCountLable = UILabel()
    private let newTaskButton = UIButton()
    
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
        view.backgroundColor = UIColor(named: "Black")
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
        appearance.backgroundColor = UIColor(named: "Black")
        appearance.largeTitleTextAttributes = [
            .foregroundColor: UIColor(named: "White") ?? .white,
            .font: UIFont.boldSystemFont(ofSize: 34)
        ]
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.tintColor = UIColor(named: "White")
        let backButton = UIBarButtonItem()
        backButton.title = "Назад"
        backButton.tintColor = UIColor(named: "Yellow")
        navigationItem.backBarButtonItem = backButton
    }
    
    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
        searchController.searchBar.tintColor = UIColor(named: "White")
        if let textField = searchController.searchBar.value(forKey: "searchField") as? UITextField {
            textField.textColor = UIColor(named: "White")
            textField.tintColor = UIColor(named: "White")
        }
    }
    
    private func setupLowerBar() {
        lowerBar.backgroundColor = UIColor(named: "Gray")
        view.addSubview(lowerBar)
        lowerBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            lowerBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            lowerBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            lowerBar.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            lowerBar.heightAnchor.constraint(equalToConstant: 83)
        ])
        addTaskCountLable()
        setupNewTaskButton()
    }
    
    private func setupTaskTableView() {
        tasksTableView.delegate = self
        tasksTableView.dataSource = self
        tasksTableView.backgroundColor = UIColor(named: "Black")
        view.addSubview(tasksTableView)
        tasksTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tasksTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tasksTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tasksTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tasksTableView.bottomAnchor.constraint(equalTo: lowerBar.topAnchor)
        ])
    }
    
    private func addTaskCountLable() {
        taskCountLable.font = UIFont.systemFont(ofSize: 11, weight: .regular)
        taskCountLable.textColor = UIColor(named: "White")
        lowerBar.addSubview(taskCountLable)
        taskCountLable.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            taskCountLable.centerXAnchor.constraint(equalTo: lowerBar.centerXAnchor),
            taskCountLable.topAnchor.constraint(equalTo: lowerBar.topAnchor, constant: 20)
        ])
    }
    
    private func setupNewTaskButton() {
        newTaskButton.setImage(.init(systemName: "square.and.pencil"), for: .normal)
        newTaskButton.tintColor = UIColor(named: "Yellow")
        newTaskButton.addTarget(self, action: #selector(newTaskButtonTapped), for: .touchUpInside)
        lowerBar.addSubview(newTaskButton)
        newTaskButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            newTaskButton.topAnchor.constraint(equalTo: lowerBar.topAnchor, constant: 13),
            newTaskButton.trailingAnchor.constraint(equalTo: lowerBar.trailingAnchor, constant: -13),
            newTaskButton.widthAnchor.constraint(equalToConstant: 28),
            newTaskButton.heightAnchor.constraint(equalToConstant: 28)
        ])
    }
    
    // MARK: - Private Actions
    
    @objc private func newTaskButtonTapped() {
        presenter?.newTaskButtonTapped()
    }
}

// MARK: - MainScreenViewControllerProtocol

extension MainScreenViewController: MainScreenViewProtocol {
    
    func reloadData() {
        tasksTableView.reloadData()
        taskCountLable.text = "\(presenter?.fillteredTasks?.count ?? 0) задач"
    }
    
    func fetchNewData() {
        presenter?.loadTodosFromCoreData()
    }
}

// MARK: - UITableViewDataSource

extension MainScreenViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.fillteredTasks?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let presenter else { return UITableViewCell()}
        guard let tasks = presenter.fillteredTasks else { return UITableViewCell()}
        let cell = MainScreenTableViewCell(todo: tasks[indexPath.row], presenter: self.presenter)
        return cell
    }
}

// MARK: - UITableViewDelegate

extension MainScreenViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 106
    }
}

// MARK: - UISearchResultsUpdating

extension MainScreenViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        presenter?.filterTodos(by: searchController.searchBar.text)
    }
}
