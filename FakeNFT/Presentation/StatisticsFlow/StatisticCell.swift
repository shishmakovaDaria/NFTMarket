//
//  StatisticCell.swift
//  FakeNFT
//
//  Created by Aleksandr Garipov on 30.07.2023.
//

import UIKit

final class StatisticCell: UITableViewCell {
    
    private lazy var avatarImageView: UIImageView = {
        let view = UIImageView()
        view.frame = CGRect(x: 0, y: 0, width: 28, height: 28)
        view.image = UIImage.bitcoin
        view.backgroundColor = .red
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupLayout()

    }
    
    private func setupUI() {
        addSubview(avatarImageView)
        avatarImageView.layer.cornerRadius = avatarImageView.bounds.height / 2
        avatarImageView.layer.masksToBounds = true
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            avatarImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            avatarImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            avatarImageView.heightAnchor.constraint(equalToConstant: 28),
            avatarImageView.widthAnchor.constraint(equalToConstant: 28)
        ]
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

