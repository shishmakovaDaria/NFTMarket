//
//  CollectionCell.swift
//  FakeNFT
//
//  Created by Aleksandr Garipov on 05.08.2023.
//

import UIKit

final class NFTCollectionCell: UICollectionViewCell {
    //MARK: - Layout properties
    private lazy var nftImageView: UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 12
        view.image = .Icons.dogecoin
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var starsImageView: UIImageView = {
        let view = UIImageView()
        view.image = .Icons.fiveStarRating
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var nftNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.text = "NFT"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var nftPriceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10)
        label.text = "0"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var cartButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(.Icons.addToCart, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var likeButton: UIButton = {
        let button = UIButton()
        let heartImage = UIImage.Icons.heartFill?.withTintColor(.red, renderingMode: .alwaysOriginal)
        button.setImage(heartImage, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    //MARK: - Lifecycle:
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Methods
    
    private func setupUI() {
        contentView.addSubview(nftImageView)
        contentView.addSubview(starsImageView)
        contentView.addSubview(nftNameLabel)
        contentView.addSubview(nftPriceLabel)
        contentView.addSubview(cartButton)
        contentView.addSubview(likeButton)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            nftImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            nftImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            nftImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            nftImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -84),
            
            starsImageView.topAnchor.constraint(equalTo: nftImageView.bottomAnchor, constant: 8),
            starsImageView.leadingAnchor.constraint(equalTo: nftImageView.leadingAnchor),
            
            nftNameLabel.topAnchor.constraint(equalTo: starsImageView.bottomAnchor, constant: 5),
            nftNameLabel.leadingAnchor.constraint(equalTo: nftImageView.leadingAnchor),
            
            nftPriceLabel.topAnchor.constraint(equalTo: nftNameLabel.bottomAnchor, constant: 4),
            nftPriceLabel.leadingAnchor.constraint(equalTo: nftImageView.leadingAnchor),
            
            cartButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            cartButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            likeButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            likeButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12)
        ])
    }
}
