//
//  CollectionCell.swift
//  FakeNFT
//
//  Created by Aleksandr Garipov on 05.08.2023.
//

struct NFTCollectionCellModel {
    let image: String
    let rating: Int
    let name: String
    let price: Float
    let isLiked: Bool
    let isInCart: Bool
}

import UIKit
import Kingfisher

final class NFTCollectionCell: UICollectionViewCell {
    //MARK: - Layout properties
    private lazy var nftImageView: UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 12
        view.layer.masksToBounds = true
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
        button.tintColor = .blackDay
        button.addTarget(self, action: #selector(cartButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var likeButton: UIButton = {
        let button = UIButton()
        let heartImage = UIImage.Icons.heartFill?.withTintColor(.whiteDay!, renderingMode: .alwaysOriginal)
        button.setImage(heartImage, for: .normal)
        button.tintColor = .whiteDay
        button.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
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
    
    
    //MARK: - Actions:
    
    var likeButtonTappedHandler: (() -> Void)?
    var cartButtonTappedHandler: (() -> Void)?
    
    @objc private func likeButtonTapped() {
        likeButtonTappedHandler?()
    }
    
    @objc private func cartButtonTapped() {
        cartButtonTappedHandler?()
    }
    
    //MARK: - Methods
    
    func configure(model: NFTCollectionCellModel) {
        if let NFTImageUrl = URL(string: model.image) {
            updateNFTImage(with: NFTImageUrl) }
        let starsImage = getStarsImage(for: model.rating)
        self.starsImageView.image = starsImage
        self.nftNameLabel.text = model.name
        self.nftPriceLabel.text = "\(model.price) ETH"
        let likeImage: UIImage = {
            if model.isLiked {
            return UIImage.Icons.heartFill!.withTintColor(.red, renderingMode: .alwaysOriginal)
        } else {return UIImage.Icons.heartFill!.withTintColor(.whiteDay!, renderingMode: .alwaysOriginal)}}()
        let cartImage: UIImage =  {
            if model.isInCart {
                return UIImage.Icons.deleteFromCart!.withTintColor(.blackDay!, renderingMode: .alwaysOriginal)
            } else {
                return UIImage.Icons.addToCart!.withTintColor(.blackDay!, renderingMode: .alwaysOriginal)
            }
        }()
        self.likeButton.setImage(likeImage, for: .normal)
        self.cartButton.setImage(cartImage, for: .normal)
        
    }
    
    
    
    private func updateNFTImage(with url: URL) {
        let cache = ImageCache.default
        cache.diskStorage.config.expiration = .seconds(1)
        
        let processor = RoundCornerImageProcessor(cornerRadius: 12, backgroundColor: .clear)
        nftImageView.kf.indicatorType = .activity
        nftImageView.kf.setImage(with: url,
                                 placeholder: nil,
                                 options: [.processor(processor),
                                           .cacheSerializer(FormatIndicatedCacheSerializer.png)])
    }
    
    private func getStarsImage(for rating: Int) -> UIImage? {
        switch rating {
        case 1:
            return UIImage.Icons.oneStarRating
        case 2:
            return UIImage.Icons.twoStarRating
        case 3:
            return UIImage.Icons.threeStarRating
        case 4:
            return UIImage.Icons.fourStarRating
        case 5:
            return UIImage.Icons.fiveStarRating
        default:
            return nil
        }
    }
    
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
