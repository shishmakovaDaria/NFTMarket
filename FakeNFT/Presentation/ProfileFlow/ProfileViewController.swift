//
//  ProfileViewController.swift
//  FakeNFT
//
//  Created by Aleksandr Garipov on 30.07.2023.
//

import UIKit

final class ProfileViewController: UIViewController {
    
    private var viewModel: ProfileViewModel?
    
    init(viewModel: ProfileViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var editButton: UIButton = {
        let editButton = UIButton(type: .system)
        editButton.setBackgroundImage(UIImage.Icons.edit, for: .normal)
        editButton.addTarget(self, action: #selector(editButtonDidTap(_:)), for: .touchUpInside)
        return editButton
    }()
    
    private lazy var profilePhoto: UIImageView = {
        let profilePhoto = UIImageView()
        profilePhoto.layer.cornerRadius = 35
        profilePhoto.backgroundColor = .blackDay
        return profilePhoto
    }()
    
    private lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.text = viewModel?.profile.name
        nameLabel.textColor = .blackDay
        nameLabel.font = .boldSystemFont(ofSize: 22)
        nameLabel.minimumScaleFactor = 15
        return nameLabel
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.text = viewModel?.profile.description
        descriptionLabel.numberOfLines = 10
        descriptionLabel.textColor = .blackDay
        descriptionLabel.font = .systemFont(ofSize: 13, weight: .regular)
        return descriptionLabel
    }()
    
    private lazy var profileWebsite: UILabel = {
        let profileWebsite = UILabel()
        profileWebsite.text = viewModel?.profile.website
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
    }
    
    @objc private func editButtonDidTap(_ sender: Any?) {
        present(ProfileEditingViewController() , animated: true)
    }
    
    private func setupUI() {
        tableView.dataSource = self
        tableView.delegate = self
        view.backgroundColor = .whiteDay
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: editButton)
        
        view.addSubview(profilePhoto)
        view.addSubview(nameLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(profileWebsite)
        view.addSubview(tableView)
        
        editButton.translatesAutoresizingMaskIntoConstraints = false
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
        let tableHeaders = viewModel?.provideTableHeaders()
        cell.textLabel?.text = tableHeaders?[indexPath.row]
        cell.textLabel?.textColor = .blackDay
        cell.textLabel?.font = .boldSystemFont(ofSize: 17)
        cell.accessoryView = UIImageView(image: UIImage.Icons.forward)
        cell.accessoryView?.tintColor = .blackDay
        cell.backgroundColor = .whiteDay
        
        return cell
    }
}

//MARK: - UITableViewDelegate
extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 54
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
