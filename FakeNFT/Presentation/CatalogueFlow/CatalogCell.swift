//
//  CatalogCell.swift
//  FakeNFT
//
//  Created by Дарья Шишмакова on 22.08.2023.
//

import Foundation
import UIKit
import Kingfisher

struct CatalogCellModel {
    let name: String
    let image: String
}

final class CatalogCell: UITableViewCell {
    
    private lazy var coverImageView: UIImageView = {
        let coverImageView = UIImageView()
        coverImageView.layer.masksToBounds = true
        coverImageView.layer.cornerRadius = 12
        coverImageView.backgroundColor = .blackDay
        coverImageView.contentMode = .scaleAspectFill
        return coverImageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.font = .bodyBold
        nameLabel.textColor = .blackDay
        return nameLabel
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupConstraints()
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(cellModel: CatalogCellModel) {
        nameLabel.text = cellModel.name
        updateNFTImage(url: cellModel.image)
    }
        
    private func updateNFTImage(url: String?) {
        guard let nftURL = URL(string: url ?? "") else { return }
        let cache = ImageCache.default
        cache.diskStorage.config.expiration = .days(1)
            
        coverImageView.kf.indicatorType = .activity
        coverImageView.kf.setImage(with: nftURL,
                                 placeholder: nil,
                                 options: [.cacheSerializer(FormatIndicatedCacheSerializer.png)])
    }
    
    private func setupUI() {
        contentView.backgroundColor = .whiteDay
            
        [coverImageView, nameLabel].forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            coverImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            coverImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            coverImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            coverImageView.heightAnchor.constraint(equalToConstant: 140),
            coverImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -39),
            
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            nameLabel.topAnchor.constraint(equalTo: coverImageView.bottomAnchor, constant: 4)
        ])
    }
}

