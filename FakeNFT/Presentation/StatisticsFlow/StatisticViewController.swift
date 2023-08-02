//
//  StatisticViewController.swift
//  FakeNFT
//
//  Created by Aleksandr Garipov on 30.07.2023.
//

import UIKit

final class StatisticViewController: UIViewController {
    

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

    private var viewModel: StatisticViewModel?
    init(viewModel: StatisticViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    override func viewDidLoad() {
        setupUI()
        setupLayout()
    }
    
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
}

//MARK: - UITableViewDelegate, UITableViewDataSource

extension StatisticViewController: UITableViewDelegate {

}

extension StatisticViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        88
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StatisticCell.reuseIdentifier, for: indexPath) as! StatisticCell
        return cell
    }
    

}

