//
//  ProfileViewController.swift
//  FakeNFT
//
//  Created by Aleksandr Garipov on 30.07.2023.
//

import UIKit

final class ProfileViewController: UIViewController {
    
    private lazy var profilePhoto: UIImageView = {
        let profilePhoto = UIImageView()
        profilePhoto.layer.cornerRadius = 35
        profilePhoto.backgroundColor = .blackDay
        return profilePhoto
    }()
    
    private lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.text = "Joaquin Phoenix"
        nameLabel.textColor = .blackDay
        nameLabel.font = .boldSystemFont(ofSize: 22)
        nameLabel.minimumScaleFactor = 15
        return nameLabel
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.text = "Дизайнер из Казани, люблю цифровое искусство и бейглы. В моей коллекции уже 100+ NFT, и еще больше — на моём сайте. Открыт к коллаборациям."
        descriptionLabel.numberOfLines = 10
        descriptionLabel.textColor = .blackDay
        descriptionLabel.font = .systemFont(ofSize: 13, weight: .regular)
        return descriptionLabel
    }()
    
    private lazy var profileWebsite: UILabel = {
        let profileWebsite = UILabel()
        profileWebsite.text = "Joaquin Phoenix.com"
        profileWebsite.textColor = .ypBlue
        profileWebsite.font = .systemFont(ofSize: 15, weight: .regular)
        return profileWebsite
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
    }
    
    private func setupUI() {
        view.backgroundColor = .whiteDay
        //navigationBar.barTintColor = .white
        //navigationBar.shadowImage = UIImage()
        
        view.addSubview(profilePhoto)
        view.addSubview(nameLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(profileWebsite)
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        profilePhoto.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        profileWebsite.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            profilePhoto.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            profilePhoto.topAnchor.constraint(equalTo: view.topAnchor, constant: 108),
            profilePhoto.heightAnchor.constraint(equalToConstant: 70),
            profilePhoto.widthAnchor.constraint(equalToConstant: 70),
            
            nameLabel.leadingAnchor.constraint(equalTo: profilePhoto.trailingAnchor, constant: 16),
            nameLabel.centerYAnchor.constraint(equalTo: profilePhoto.centerYAnchor),
            
            descriptionLabel.leadingAnchor.constraint(equalTo: profilePhoto.leadingAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: profilePhoto.bottomAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -18),
            
            profileWebsite.leadingAnchor.constraint(equalTo: profilePhoto.leadingAnchor),
            profileWebsite.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 12)
        ])
    }
}
