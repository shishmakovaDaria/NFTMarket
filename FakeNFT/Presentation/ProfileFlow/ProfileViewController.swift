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
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorColor = .whiteDay
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    private var tableHeaders = [
        "Мои NFT (112)",
        "Избранные NFT (11)",
        "О разработчике"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
    }
    
    private func setupUI() {
        tableView.dataSource = self
        tableView.delegate = self
        view.backgroundColor = .whiteDay
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: UIImageView(image: .edit))
        
        view.addSubview(profilePhoto)
        view.addSubview(nameLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(profileWebsite)
        view.addSubview(tableView)
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        profilePhoto.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        profileWebsite.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
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
            profileWebsite.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 12),
            
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.heightAnchor.constraint(equalToConstant: 162),
            tableView.topAnchor.constraint(equalTo: profileWebsite.bottomAnchor, constant: 40)
        ])
    }
}

//MARK: - UITableViewDataSource
extension ProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = tableHeaders[indexPath.row]
        cell.textLabel?.textColor = .blackDay
        cell.textLabel?.font = .boldSystemFont(ofSize: 17)
        cell.accessoryType = .disclosureIndicator
        cell.backgroundColor = .whiteDay
        
        return cell
    }
}

//MARK: - UITableViewDelegate
extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 54
    }
}
