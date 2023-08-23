//
//  FavoriteNFTsCell.swift
//  FakeNFT
//
//  Created by Дарья Шишмакова on 17.08.2023.
//

import Foundation
import UIKit
import Kingfisher

struct FavoriteNFTsCellModel {
    let name: String
    let image: String
    let rating: Int
    let price: String
}

final class FavoriteNFTsCell: UICollectionViewCell {
    
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
        likeButton.tintColor = .ypRed
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
    
    private lazy var priceLabel: UILabel = {
        let priceLabel = UILabel()
        priceLabel.font = .caption1
        priceLabel.textColor = .blackDay
        return priceLabel
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nftNameLabel.text = nil
        likeButton.tintColor = .ypRed
        starsImageView.image = getStarsImage(for: 0)
        priceLabel.text = nil
        nftImageView.image = nil
        nftImageView.kf.cancelDownloadTask()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var likeButtonTappedHandler: (() -> Void)?
    
    @objc private func likeButtonDidTap(_ sender: Any?) {
        likeButton.tintColor = .ypWhite
        likeButtonTappedHandler?()
    }
    
    func configureCell(cellModel: FavoriteNFTsCellModel) {
        nftNameLabel.text = cellModel.name
        updateNFTImage(url: cellModel.image)
        starsImageView.image = getStarsImage(for: cellModel.rating)
        priceLabel.text = cellModel.price
    }
    
    private func updateNFTImage(url: String?) {
        guard let nftURL = URL(string: url ?? "") else { return }
        let cache = ImageCache.default
        cache.diskStorage.config.expiration = .days(1)
        
        nftImageView.kf.indicatorType = .activity
        nftImageView.kf.setImage(with: nftURL,
                                 placeholder: nil,
                                 options: [.cacheSerializer(FormatIndicatedCacheSerializer.png)])
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
        
        [nftImageView, likeButton, nameStackView].forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        [nftNameLabel, starsImageView, priceLabel].forEach {
            nameStackView.addArrangedSubview($0)
        }
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            nftImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            nftImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            nftImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            nftImageView.widthAnchor.constraint(equalToConstant: 80),
            nftImageView.heightAnchor.constraint(equalToConstant: 80),
            
            likeButton.topAnchor.constraint(equalTo: nftImageView.topAnchor, constant: 5),
            likeButton.trailingAnchor.constraint(equalTo: nftImageView.trailingAnchor, constant: -5),
            
            nameStackView.leadingAnchor.constraint(equalTo: nftImageView.trailingAnchor, constant: 12),
            nameStackView.topAnchor.constraint(equalTo: nftImageView.topAnchor, constant: 7),
            nameStackView.bottomAnchor.constraint(equalTo: nftImageView.bottomAnchor, constant: -7),
            nameStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
}
