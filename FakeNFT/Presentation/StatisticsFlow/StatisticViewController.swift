//
//  StatisticViewController.swift
//  FakeNFT
//
//  Created by Aleksandr Garipov on 30.07.2023.
//

import UIKit

final class StatisticViewController: UIViewController {
    
    //MARK: - Layout properties
    
    private lazy var sortButton: UIButton = {
        let button = UIButton(type: .system)
        button.setBackgroundImage(UIImage.Icons.sort, for: .normal)
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

    private var viewModel: StatisticViewModel?
    
    //MARK: - LifeCyle
    
    init(viewModel: StatisticViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    override func viewDidLoad() {
        bind()
        setupUI()
        setupLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel?.startObserve()
    }
    
    // MARK: - Methods
    
    private func setupUI() {
        statsTableView.delegate = self
        statsTableView.dataSource = self
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
        guard let viewModel = viewModel else { return }
        viewModel.$staticsCellModels.bind { [weak self] _ in
            self?.statsTableView.reloadData()
        }
    }
}

//MARK: - UITableViewDelegate, UITableViewDataSource

extension StatisticViewController: UITableViewDelegate {

}

extension StatisticViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.staticsCellModels.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        88
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StatisticCell.reuseIdentifier, for: indexPath) as! StatisticCell
        guard let model = viewModel?.staticsCellModels[indexPath.row] else { return cell}
        let indexNumber = indexPath.row + 1
        cell.configure(model: model, indexNumber: indexNumber)
        return cell
    }
    

}

