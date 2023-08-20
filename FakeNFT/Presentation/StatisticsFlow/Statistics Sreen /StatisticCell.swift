//
//  StatisticCell.swift
//  FakeNFT
//
//  Created by Aleksandr Garipov on 30.07.2023.
//

import UIKit
import Kingfisher

struct StatisticCellModel {
    let name: String
    let avatar: String
    let rating: String
    let indexNumber: Int
}

final class StatisticCell: UITableViewCell {
    
    //MARK: - Layout properties
    
    private lazy var backgroundColorView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 12
        view.backgroundColor = .lightGrayDay
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var avatarImageView: UIImageView = {
        let view = UIImageView()
        view.frame = CGRect(x: 0, y: 0, width: 28, height: 28)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var numberOfCell: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.font = UIFont.systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Dog"
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var countLabel: UILabel = {
        let label = UILabel()
        label.text = "333"
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none

        setupUI()
        setupLayout()

    }
    
    //MARK: - Methods
    
    func configure(model: StatisticCellModel) {
        nameLabel.text = model.name
        countLabel.text = "\(model.rating)"
        numberOfCell.text = "\(model.indexNumber)"
        setAvatarImage(model: model)
    }
    
    private func setAvatarImage(model: StatisticCellModel) {
        let avatarUrl = URL(string: model.avatar)
        
        let cache = ImageCache.default
        cache.diskStorage.config.expiration = .seconds(1)
        
        let processor = RoundCornerImageProcessor(cornerRadius: 35, backgroundColor: .clear)
        avatarImageView.kf.indicatorType = .activity
        avatarImageView.kf.setImage(with: avatarUrl,
                                 placeholder: nil,
                                 options: [.processor(processor),
                                           .cacheSerializer(FormatIndicatedCacheSerializer.png)])
    }
    
    private func setupUI() {
        addSubview(backgroundColorView)
        addSubview(avatarImageView)
        addSubview(numberOfCell)
        addSubview(nameLabel)
        addSubview(countLabel)
        avatarImageView.layer.cornerRadius = avatarImageView.bounds.height / 2
        avatarImageView.layer.masksToBounds = true
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            backgroundColorView.topAnchor.constraint(equalTo: topAnchor),
            backgroundColorView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundColorView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            backgroundColorView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 35),
            
            avatarImageView.centerYAnchor.constraint(equalTo: backgroundColorView.centerYAnchor),
            avatarImageView.leadingAnchor.constraint(equalTo: backgroundColorView.leadingAnchor, constant: 16),
            avatarImageView.heightAnchor.constraint(equalToConstant: 28),
            avatarImageView.widthAnchor.constraint(equalToConstant: 28),
            
            numberOfCell.centerYAnchor.constraint(equalTo: backgroundColorView.centerYAnchor),
            numberOfCell.trailingAnchor.constraint(equalTo: backgroundColorView.leadingAnchor, constant: -12),
            
            nameLabel.centerYAnchor.constraint(equalTo: backgroundColorView.centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 8),
            
            countLabel.centerYAnchor.constraint(equalTo: backgroundColorView.centerYAnchor),
            countLabel.trailingAnchor.constraint(equalTo: backgroundColorView.trailingAnchor, constant: -16)
        ]
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

