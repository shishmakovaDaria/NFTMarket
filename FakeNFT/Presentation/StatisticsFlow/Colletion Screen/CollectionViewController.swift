//
//  CollectionViewController.swift
//  FakeNFT
//
//  Created by Aleksandr Garipov on 04.08.2023.
//

import UIKit

final class CollectionViewController: UIViewController {
    
    // MARK: - Layout properties
    
    private lazy var navBarTitle: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "NFT Collection".localized()
        titleLabel.textColor = .blackDay
        titleLabel.font = UIFont.boldSystemFont(ofSize: 17)
        titleLabel.sizeToFit()
        return titleLabel
    }()
    
    private lazy var nftCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.allowsMultipleSelection = false
        collectionView.register(NFTCollectionCell.self, forCellWithReuseIdentifier: NFTCollectionCell.reuseIdentifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    //MARK: - Properties
    
    private var viewModel: CollectionViewModelProtocol
    
    // MARK: - LifeCycle
    
    init(viewModel: CollectionViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        setupUI()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        viewModel.viewDidLoad()
    }
    
    //MARK: - Actions
    
    private func handleLikeButtonTapped(at indexPath: IndexPath) {
        viewModel.likeButtonTapped(at: indexPath)
    }
    
    private func handleCartButtonTapped(at indexPath: IndexPath) {
        viewModel.cartButtonTapped(at: indexPath)
    }
    
    // MARK: - Methods
    
    private func setupUI() {
        navigationItem.titleView = navBarTitle
        nftCollectionView.delegate = self
        nftCollectionView.dataSource = self
        view.addSubview(nftCollectionView)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            nftCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            nftCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            nftCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            nftCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
    
    private func bind() {
        viewModel.nftsObservable.bind { [weak self] _ in
            self?.nftCollectionView.reloadData()
        }
        viewModel.likesObservable.bind { [weak self] _ in
            self?.nftCollectionView.reloadData()
        }
        viewModel.cartNFTsObservable.bind { [weak self] _ in
            self?.nftCollectionView.reloadData()
        }
        viewModel.isLoadingObservable.bind { isLoading in
            isLoading ? UIBlockingProgressHUD.show() : UIBlockingProgressHUD.dismiss()
        }
    }
}

//MARK: - UICollectionViewDelegateFlowLayout & UICollectionViewDataSource

extension CollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.nfts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NFTCollectionCell.reuseIdentifier, for: indexPath) as? NFTCollectionCell else { return UICollectionViewCell() }
        let nftCollectionCellModel = viewModel.getCellModel(at: indexPath)
        cell.configure(model: nftCollectionCellModel)
        cell.likeButtonTappedHandler = { [weak self] in
            self?.handleLikeButtonTapped(at: indexPath)
        }
        cell.cartButtonTappedHandler = { [weak self] in
            self?.handleCartButtonTapped(at: indexPath)
        }
        return cell
    }
}

extension CollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (nftCollectionView.bounds.width - 20) / 3
        let height = width * 1.78
        return CGSize(width: width, height: height)
    }
}
