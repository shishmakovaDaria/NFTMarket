//
//  CartViewController.swift
//  FakeNFT
//
//  Created by Aleksandr Garipov on 30.07.2023.
//

import UIKit
import ProgressHUD


final class CartViewController: UIViewController {
    
    //MARK: - Layout properties
    
    private lazy var sortButton = UIBarButtonItem(
        image: UIImage.Icons.sort,
        style: .plain,
        target: self,
        action: #selector(didTapSortButton)
    )
    
    private lazy var emptyLabel: UILabel = {
        let label = UILabel()
        label.text = "Cart is empty".localized()
        label.font = UIFont.bodyBold
        label.isHidden = true
        return label
    }()
    
    private lazy var cartTableView: UITableView = {
        let table = UITableView()
        table.register(
            CartNFTCell.self,
            forCellReuseIdentifier: CartNFTCell.reuseIdentifier
        )
        table.separatorStyle = .none
        table.backgroundColor = .clear
        table.allowsSelection = false
        return table
    }()
    
    private lazy var summaryView: SummaryView = {
        let view = SummaryView()
        view.delegate = self
        return view
    }()
        
    // MARK: - Properties
    
    private var viewModel: CartViewModelProtocol
    
    //MARK: - LifeCycle
    
    init(viewModel: CartViewModelProtocol = CartViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cartTableView.delegate = self
        cartTableView.dataSource = self
        
        bind()
        setLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.startObserve()
    }
    
    //MARK: - Actions
    
    @objc
    private func didTapSortButton() {
        showAlertSort(viewModel: viewModel as! Sortable, valueSort: .cart)
        cartTableView.reloadData()
    }
        
    //MARK: - Methods
    
    private func bind() {

        viewModel.isLoadingObservable.bind { [weak self] isLoading in
            if isLoading {
                UIBlockingProgressHUD.show()
            } else {
                UIBlockingProgressHUD.dismiss()
                self?.cartTableView.reloadData()
            }
        }
        
        viewModel.isCartEmptyObservable.bind { [weak self] isCartEmpry in
            if isCartEmpry {
                self?.showEmptyCartPlaceholder()
            } else {
                self?.showCart()
            }
        }
        
        viewModel.nftsObservable.bind { [weak self] _ in
            guard let self else { return }
            UIView.animate(withDuration: 0.3) {
                self.summaryView.configureSummary(with: self.viewModel.summaryInfo)
            }
            self.cartTableView.reloadData()
        }
        
    }
    
    private func showEmptyCartPlaceholder() {
        emptyLabel.isHidden = false
        navigationController?.navigationBar.isHidden = true
        cartTableView.isHidden = true
        summaryView.isHidden = true
    }
    
    private func showCart() {
        emptyLabel.isHidden = true
        navigationController?.navigationBar.isHidden = false
        cartTableView.isHidden = false
        summaryView.isHidden = false
    }
    
    private func setLayout() {
        view.backgroundColor = .whiteDay
        
        [emptyLabel, cartTableView, summaryView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        setNavBar()
        setConstraints()
    }
    
    private func setNavBar() {
        navigationItem.rightBarButtonItem = sortButton
        navigationController?.navigationBar.tintColor = .blackDay
        navigationController?.navigationBar.backgroundColor = .whiteDay
        navigationController?.navigationBar.prefersLargeTitles = false
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
        let checkPayVC = CheckPayViewController()
        checkPayVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(checkPayVC, animated: true)
    }
}

// MARK: - CartNFTCellDelegate

extension CartViewController: CartNFTCellDelegate {
    func didTapDeleteButton(on nft: NFTModel) {
        let deleteFromCartVC = DeleteFromCartViewController()
        deleteFromCartVC.nftForDelete = nft
        deleteFromCartVC.delegate = self
        deleteFromCartVC.modalPresentationStyle = .overFullScreen
        deleteFromCartVC.modalTransitionStyle = .crossDissolve
        present(deleteFromCartVC, animated: true)
    }
}

// MARK: - UITableViewDataSource

extension CartViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.nfts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CartNFTCell = cartTableView.dequeueReusableCell()
        let model = viewModel.nfts[indexPath.row]
        cell.delegate = self
        cell.configureCell(with: model)
        
        return cell
    }
}

// MARK: - UITableViewDelegate

extension CartViewController: UITableViewDelegate {}

// MARK: - DeleteFromCartViewControllerDelegate

extension CartViewController: DeleteFromCartViewControllerDelegate {
    func didTapReturnButton() {
        dismiss(animated: true)
    }
    
    func didTapDeleteButton(_ model: NFTModel) {
        viewModel.deleteNFT(model) { [weak self] in
            self?.dismiss(animated: true)
        }
    }
    
}

