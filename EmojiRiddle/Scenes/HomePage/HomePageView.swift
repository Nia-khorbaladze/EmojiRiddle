//
//  HomePageView.swift
//  EmojiRiddle
//
//  Created by Nkhorbaladze on 27.12.24.
//
import UIKit

final class HomePageView: UIViewController {
    
    private var viewModel = HomePageViewModel()
    private var questionsViewModel = QuestionViewModel.shared
    
    //MARK: - UI Elements
    private lazy var appTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(hexString: "FFDAF9")
        label.font = .systemFont(ofSize: 36, weight: .bold)
        label.text = "Emoji Riddle"
        
        return label
    }()
    
    private lazy var categoryTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(CategoryTableViewCell.self, forCellReuseIdentifier: CategoryTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        
        return tableView
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hexString: "100735")
        setupConstraints()
        reloadCategories()
        viewModel.fetchCategories()
    }
    
    // MARK: - Private functions
    private func setupConstraints() {
        view.addSubview(appTitle)
        view.addSubview(categoryTableView)
        
        NSLayoutConstraint.activate([
            appTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            appTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            appTitle.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        NSLayoutConstraint.activate([
            categoryTableView.widthAnchor.constraint(equalToConstant: 240),
            categoryTableView.heightAnchor.constraint(equalToConstant: 300),
            categoryTableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            categoryTableView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    private func reloadCategories() {
        viewModel.didUpdateCategories = { [weak self] in
            DispatchQueue.main.async {
                self?.categoryTableView.reloadData()
            }
        }
    }
}

// MARK: - Extensions
extension HomePageView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CategoryTableViewCell.identifier, for: indexPath) as? CategoryTableViewCell else {
            return UITableViewCell()
        }
        
        let category = viewModel.categories[indexPath.row]
        cell.configureCell(text: category)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCategory = viewModel.categories[indexPath.row]
        
        let questionPageVC = QuestionPageView()
        questionsViewModel.selectedCategory = selectedCategory
        
        navigationController?.pushViewController(questionPageVC, animated: true)
    }
}


