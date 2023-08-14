//
//  MyNFTsViewController.swift
//  FakeNFT
//
//  Created by Дарья Шишмакова on 02.08.2023.
//

import UIKit
import ProgressHUD

final class MyNFTsViewController: UIViewController {
    
    private var viewModel: MyNFTsViewModel?
    
    init(viewModel: MyNFTsViewModel) {
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
    
    private lazy var placeholder: UILabel = {
        let placeholder = UILabel()
        placeholder.text = "You don't have NFT yet".localized()
        placeholder.textColor = .blackDay
        placeholder.font = .bodyBold
        return placeholder
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.backgroundColor = .whiteDay
        tableView.register(MyNFTsCell.self, forCellReuseIdentifier: MyNFTsCell.reuseIdentifier)
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
        UIBlockingProgressHUD.show()
        viewModel?.updateNFTs()
    }
    
    @objc private func sortButtonDidTap(_ sender: Any?) {
        guard let viewModel = viewModel else { return }
        showAlertSort(viewModel: viewModel, valueSort: .profile)
    }
    
    private func reloadPlaceholder() {
        if viewModel?.nfts.count == 0 {
            placeholder.isHidden = false
            navigationItem.title = ""
            sortButton.isHidden = true
            tableView.isHidden = true
        } else {
            placeholder.isHidden = true
            navigationItem.title = "My NFTs".localized()
            sortButton.isHidden = false
            tableView.isHidden = false
        }
    }
    
    private func bind() {
        UIBlockingProgressHUD.show()
        viewModel?.$nfts.bind() { [weak self] _ in
            self?.tableView.reloadData()
            self?.reloadPlaceholder()
            UIBlockingProgressHUD.dismiss()
        }
        
        viewModel?.$nftsAuthors.bind() { [weak self] _ in
            self?.tableView.reloadData()
        }
    }
    
    private func setupUI() {
        view.backgroundColor = .whiteDay
        navigationController?.navigationBar.topItem?.backButtonTitle = ""
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.tintColor = .blackDay
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: sortButton)
        
        [placeholder, tableView].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            placeholder.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            placeholder.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

//MARK: - UITableViewDataSource
extension MyNFTsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.nfts.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: MyNFTsCell.reuseIdentifier, for: indexPath) as? MyNFTsCell else { return UITableViewCell()}
        guard let cellModel = viewModel?.configureCellModel(nftIndex: indexPath.row) else { return UITableViewCell()}
        
        cell.configureCell(cellModel: cellModel)
        cell.likeButtonTappedHandler = { [weak self] in
            self?.viewModel?.handleLikeButtonTapped(nftIndex: indexPath.row)
        }
        
        return cell
    }
}

//MARK: - UITableViewDelegate
extension MyNFTsViewController: UITableViewDelegate {
    
}
