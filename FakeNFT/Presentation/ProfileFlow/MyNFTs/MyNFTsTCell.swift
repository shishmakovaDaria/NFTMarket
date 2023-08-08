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
    
    private lazy var nftNameLabel: UILabel = {
        let nftNameLabel = UILabel()
        nftNameLabel.font = .boldSystemFont(ofSize: 17)
        nftNameLabel.textColor = .blackDay
        return nftNameLabel
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupConstraints()
    }
    
    func configureCell(nft: NFTModel) {
        nftNameLabel.text = nft.name
        updateNFTImage(url: nft.images.first)
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
    
    private func setupUI() {
        contentView.backgroundColor = .whiteDay
        
        contentView.addSubview(nftImageView)
        contentView.addSubview(nftNameLabel)
        
        nftImageView.translatesAutoresizingMaskIntoConstraints = false
        nftNameLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            nftImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            nftImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            nftImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            nftImageView.widthAnchor.constraint(equalToConstant: 108),
            nftImageView.heightAnchor.constraint(equalToConstant: 108),
            
            nftNameLabel.leadingAnchor.constraint(equalTo: nftImageView.trailingAnchor, constant: 20),
            nftNameLabel.topAnchor.constraint(equalTo: nftImageView.topAnchor, constant: 23),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - ReuseIdentifying
extension MyNFTsCell: ReuseIdentifying {}
