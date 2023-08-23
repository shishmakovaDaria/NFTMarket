//
//  CatalogViewController.swift
//  FakeNFT
//
//  Created by Aleksandr Garipov on 30.07.2023.
//

import UIKit
import ProgressHUD

final class CatalogViewController: UIViewController {
    
    private var viewModel: CatalogueViewModelProtocol
    
    init(viewModel: CatalogueViewModelProtocol = CatalogueViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var sortButton: UIButton = {
        let editButton = UIButton(type: .system)
        editButton.setBackgroundImage(UIImage.Icons.sort, for: .normal)
        editButton.addTarget(self, action: #selector(sortButtonDidTap(_:)), for: .touchUpInside)
        return editButton
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 8, right: 0)
        tableView.backgroundColor = .whiteDay
        tableView.register(CatalogCell.self, forCellReuseIdentifier: CatalogCell.reuseIdentifier)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        bind()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.updateCollections()
    }
    
    @objc private func sortButtonDidTap(_ sender: Any?) {
        showAlertSort(viewModel: viewModel, valueSort: .catalogue)
    }
    
    private func bind() {
        viewModel.collectionsObservable.bind() { [weak self] _ in
            self?.tableView.reloadData()
        }
            
        viewModel.isLoadingObservable.bind() { isLoading in
            if isLoading {
                UIBlockingProgressHUD.show()
            } else {
                UIBlockingProgressHUD.dismiss()
            }
        }
    }
    
    private func setupUI() {
        view.backgroundColor = .whiteDay
        navigationController?.navigationBar.topItem?.backButtonTitle = ""
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: sortButton)
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

//MARK: - UITableViewDataSource
extension CatalogViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.collections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: CatalogCell.reuseIdentifier, for: indexPath) as? CatalogCell else { return UITableViewCell()}
        
        let cellModel = viewModel.configureCellModel(nftIndex: indexPath.row)
        cell.configureCell(cellModel: cellModel)
             
        return cell
    }
}

//MARK: - UITableViewDelegate
extension CatalogViewController: UITableViewDelegate {}
