//
//  FavoriteNFTsViewController.swift
//  FakeNFT
//
//  Created by Дарья Шишмакова on 02.08.2023.
//

import UIKit

final class FavoriteNFTsViewController: UIViewController {
    
    //MARK: - Layout properties
    private lazy var placeholder: UILabel = {
        let placeholder = UILabel()
        placeholder.text = "You don't have any favorite NFTs yet".localized()
        placeholder.textColor = .blackDay
        placeholder.font = .bodyBold
        return placeholder
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.register(FavoriteNFTsCell.self, forCellWithReuseIdentifier: FavoriteNFTsCell.reuseIdentifier)
        collectionView.backgroundColor = .whiteDay
        collectionView.allowsMultipleSelection = false
        return collectionView
    }()
    
    //MARK: - Properties
    private var viewModel: FavoriteNFTsViewModelProtocol
    
    //MARK: - LifeCycle
    init(viewModel: FavoriteNFTsViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        bind()
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.updateNFTs()
        reloadPlaceholder()
    }
    
    //MARK: - Methods
    private func reloadPlaceholder() {
        if viewModel.nfts.count == 0 {
            placeholder.isHidden = false
            navigationItem.title = ""
            collectionView.isHidden = true
        } else {
            placeholder.isHidden = true
            navigationItem.title = "Favorite NFTs".localized()
            collectionView.isHidden = false
        }
    }
    
    private func bind() {
        viewModel.nftsObservable.bind() { [weak self] _ in
            self?.collectionView.reloadData()
            self?.reloadPlaceholder()
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
        navigationController?.navigationBar.tintColor = .blackDay
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        [placeholder, collectionView].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            placeholder.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            placeholder.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
}

//MARK: - UICollectionViewDataSource
extension FavoriteNFTsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.nfts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: FavoriteNFTsCell.reuseIdentifier, for: indexPath) as? FavoriteNFTsCell else { return UICollectionViewCell()}
        let cellModel = viewModel.configureCellModel(nftIndex: indexPath.row)
        
        cell.configureCell(cellModel: cellModel)
        cell.likeButtonTappedHandler = { [weak self] in
            self?.viewModel.handleLikeButtonTapped(nftIndex: indexPath.row)
        }
        
        return cell
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension FavoriteNFTsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: (collectionView.bounds.width - 7) / 2, height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
}
