//
//  CartViewController.swift
//  FakeNFT
//
//  Created by Aleksandr Garipov on 30.07.2023.
//

import UIKit

final class CartViewController: UIViewController {
    
    //MARK: - Layout properties
    private lazy var sortButton = UIBarButtonItem(
        image: UIImage.sort,
        style: .plain,
        target: self,
        action: #selector(didTapSortButton)
    )
    
    private lazy var emptyLabel: UILabel = {
        let label = UILabel()
        label.text = "Корзина пуста"
        label.font = UIFont.bodyBold
        return label
    }()
    
    private lazy var cartTableView: UITableView = {
        let table = UITableView()
        table.separatorStyle = .none
        table.backgroundColor = .clear
        table.allowsSelection = false
        return table
    }()
    
    private lazy var summaryView: SummaryView = {
        let view = SummaryView()
        
        return view
    }()
    
    
    //MARK: - LifeCircle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind()
        setLayout()
    }
    
    //MARK: - Actions
    @objc
    private func didTapSortButton() {
        
    }
    
    
    //MARK: - Methods
    
    private func bind() {
        // TO DO
    }
    
    private func setLayout() {
        view.backgroundColor = .ypWhite
        
        navigationItem.rightBarButtonItem = sortButton
        navigationController?.navigationBar.tintColor = .blackDay
        
        [emptyLabel, cartTableView, summaryView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        setConstraints()
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
         
            summaryView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            summaryView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            summaryView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
           
            cartTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            cartTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            cartTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            cartTableView.bottomAnchor.constraint(equalTo: summaryView.topAnchor),
            
            emptyLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            emptyLabel.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor)
        ])
    }
}

// MARK: - SummaryViewDelegate
extension CartViewController: SummaryViewDelegate {
    func didTapToPayButton() {
        
    }
}

// MARK: - UITableViewDataSource
//extension CartViewController: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        <#code#>
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        <#code#>
//    }
//
//
//}

// MARK: - UITableViewDelegate
extension CartViewController: UITableViewDelegate {
    
}

