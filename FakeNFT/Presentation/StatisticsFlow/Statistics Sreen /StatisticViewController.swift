//
//  StatisticViewController.swift
//  FakeNFT
//
//  Created by Aleksandr Garipov on 30.07.2023.
//

import UIKit
import Kingfisher


final class StatisticViewController: UIViewController {
    
    //MARK: - Layout properties
    
    private lazy var sortButton: UIButton = {
        let button = UIButton(type: .system)
        button.setBackgroundImage(UIImage.Icons.sort, for: .normal)
        button.addTarget(self, action: #selector(sortButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var statsTableView: UITableView = {
        let tableView = UITableView(frame: view.bounds)
        tableView.separatorStyle = .none
        tableView.register(StatisticCell.self, forCellReuseIdentifier: StatisticCell.reuseIdentifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    // MARK: - Properties

    private var viewModel: StatisticViewModel
    
    //MARK: - LifeCyle
    
    init(viewModel: StatisticViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        setupUI()
        setupLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.startObserve()
    }
    
    // MARK: - Actions
    @objc
    private func sortButtonTapped() {
        showAlertSort(viewModel: viewModel, valueSort: .statistic)
    }
    
    
    // MARK: - Methods
    
    private func setupUI() {
        statsTableView.delegate = self
        statsTableView.dataSource = self
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.tintColor = .blackDay
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: sortButton)
        view.addSubview(statsTableView)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            statsTableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            statsTableView.trailingAnchor.constraint(equalTo: view
                .trailingAnchor, constant: -16),
            statsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            statsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func bind() {
        viewModel.$users.bind { [weak self] _ in
            self?.statsTableView.reloadData()
        }
        viewModel.$isLoading.bind { [weak self] isLoading in
            isLoading ? UIBlockingProgressHUD.show() : UIBlockingProgressHUD.dismiss()
        }
    }
}

//MARK: - UITableViewDelegate, UITableViewDataSource

extension StatisticViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let userModel = viewModel.users[indexPath.row]
        let userViewModel = UserViewModel(user: userModel)
        let userViewController = UserViewController(viewModel: userViewModel)
        navigationController?.pushViewController(userViewController, animated: true)
    }
}

extension StatisticViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.users.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        88
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StatisticCell.reuseIdentifier, for: indexPath) as! StatisticCell
        let indexNumber = indexPath.row + 1
            //TODO: - Отдать создание cellModel в viewModel
        let userModel = viewModel.users[indexPath.row]
        let cellModel = StatisticCellModel(name: userModel.name,
                                           avatar: userModel.avatar,
                                           rating: userModel.rating,
                                           indexNumber: indexNumber)

        cell.configure(model: cellModel)
        return cell
    }
    

}

