//
//  MyNFTsTCell.swift
//  FakeNFT
//
//  Created by Дарья Шишмакова on 08.08.2023.
//

import Foundation
import UIKit
import Kingfisher

final class MyNFTsCell: UITableViewCell {
    
    private lazy var nftImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 12
        imageView.backgroundColor = .blackDay
        return imageView
    }()
    
    private lazy var likeButton: UIButton = {
        let likeButton = UIButton(type: .system)
        likeButton.setBackgroundImage(UIImage.Icons.heartFill, for: .normal)
        likeButton.tintColor = .ypWhite
        likeButton.addTarget(self, action: #selector(likeButtonDidTap(_:)), for: .touchUpInside)
        return likeButton
    }()
    
    private lazy var nameStackView: UIStackView = {
        let nameStackView = UIStackView()
        nameStackView.axis = .vertical
        nameStackView.alignment = .fill
        nameStackView.spacing = 4
        nameStackView.distribution = .fillEqually
        return nameStackView
    }()
    
    private lazy var nftNameLabel: UILabel = {
        let nftNameLabel = UILabel()
        nftNameLabel.font = .bodyBold
        nftNameLabel.textColor = .blackDay
        return nftNameLabel
    }()
    
    private lazy var starsImageView: UIImageView = {
        let starsImageView = UIImageView()
        starsImageView.contentMode = .left
        return starsImageView
    }()
    
    private lazy var authorLabel: UILabel = {
        let authorLabel = UILabel()
        authorLabel.font = .caption2
        authorLabel.textColor = .blackDay
        return authorLabel
    }()
    
    private lazy var priceStackView: UIStackView = {
        let priceStackView = UIStackView()
        priceStackView.axis = .vertical
        priceStackView.alignment = .fill
        priceStackView.spacing = 2
        priceStackView.distribution = .fillEqually
        priceStackView.contentMode = .scaleToFill
        return priceStackView
    }()
    
    private lazy var priceLabel: UILabel = {
        let priceLabel = UILabel()
        priceLabel.font = .caption2
        priceLabel.textColor = .blackDay
        priceLabel.text = "Цена"
        return priceLabel
    }()
    
    private lazy var currentPriceLabel: UILabel = {
        let currentPriceLabel = UILabel()
        currentPriceLabel.font = .bodyBold
        currentPriceLabel.textColor = .blackDay
        return currentPriceLabel
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupConstraints()
    }
    
    @objc private func likeButtonDidTap(_ sender: Any?) {
        //TODO: - sprint 20
    }
    
    func configureCell(nft: NFTModel) {
        nftNameLabel.text = nft.name
        updateNFTImage(url: nft.images.first)
        starsImageView.image = getStarsImage(for: nft.rating)
        authorLabel.text = "от \(nft.author)"  //TODO: - sprint 20: get author name
        currentPriceLabel.text = "\(nft.price) ETH"
    }
    
    private func updateNFTImage(url: String?) {
        guard let nftURL = URL(string: url ?? "") else { return }
        let cache = ImageCache.default
        cache.diskStorage.config.expiration = .days(1)
        
        let processor = RoundCornerImageProcessor(cornerRadius: 12, backgroundColor: .clear)
        nftImageView.kf.indicatorType = .activity
        nftImageView.kf.setImage(with: nftURL,
                                 placeholder: nil,
                                 options: [.processor(processor),
                                           .cacheSerializer(FormatIndicatedCacheSerializer.png)])
    }
    
    private func getStarsImage(for rating: Int) -> UIImage? {
        switch rating {
        case 0:
            return UIImage.Icons.zeroStarRating
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
        contentView.backgroundColor = .whiteDay
        
        [nftImageView, likeButton, nameStackView, priceStackView].forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        [nftNameLabel, starsImageView, authorLabel].forEach {
            nameStackView.addArrangedSubview($0)
        }
        
        [priceLabel, currentPriceLabel].forEach {
            priceStackView.addArrangedSubview($0)
        }
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            nftImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            nftImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            nftImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            nftImageView.widthAnchor.constraint(equalToConstant: 108),
            nftImageView.heightAnchor.constraint(equalToConstant: 108),
            
            likeButton.topAnchor.constraint(equalTo: nftImageView.topAnchor, constant: 12),
            likeButton.trailingAnchor.constraint(equalTo: nftImageView.trailingAnchor, constant: -12),
            
            nameStackView.leadingAnchor.constraint(equalTo: nftImageView.trailingAnchor, constant: 20),
            nameStackView.topAnchor.constraint(equalTo: nftImageView.topAnchor, constant: 23),
            nameStackView.bottomAnchor.constraint(equalTo: nftImageView.bottomAnchor, constant: -23),
            nameStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -153),
            
            priceStackView.leadingAnchor.constraint(equalTo: nameStackView.trailingAnchor, constant: 39),
            priceStackView.topAnchor.constraint(equalTo: nameStackView.topAnchor, constant: 10),
            priceStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -39),
            priceStackView.bottomAnchor.constraint(equalTo: nameStackView.bottomAnchor, constant: -10)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - ReuseIdentifying
extension MyNFTsCell: ReuseIdentifying {}
