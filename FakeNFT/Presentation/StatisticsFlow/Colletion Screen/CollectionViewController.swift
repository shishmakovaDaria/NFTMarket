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
    
    private var viewModel: CollectionViewModel?
    
    // MARK: - LifeCycle
    
    init(viewModel: CollectionViewModel) {
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
        setupUI()
        setupLayout()
        bind()
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
            nftCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            nftCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            nftCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            nftCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
    
    private func bind() {
        guard let viewModel  else { return }
        viewModel.$nfts.bind { [weak self] _ in
            self?.nftCollectionView.reloadData()
        }
    }
}

//MARK: - UICollectionViewDelegateFlowLayout & UICollectionViewDataSource


extension CollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let viewModel else { return 0}
        return viewModel.nfts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NFTCollectionCell.reuseIdentifier, for: indexPath) as! NFTCollectionCell
        guard let nftModel = viewModel?.nfts[indexPath.row] else { return cell }
        let nftCollectionCellModel = NFTCollectionCellModel(image: nftModel.images[0], rating: nftModel.rating, name: nftModel.name, price: nftModel.price)
        cell.configure(model: nftCollectionCellModel)
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

