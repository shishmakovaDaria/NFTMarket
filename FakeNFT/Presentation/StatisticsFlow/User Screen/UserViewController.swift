//
//  UserViewController.swift
//  FakeNFT
//
//  Created by Aleksandr Garipov on 03.08.2023.
//

import UIKit
import Kingfisher

final class UserViewController: UIViewController {
    
    private var viewModel: UserViewModel?
    private var indexPath: IndexPath?
    
    //MARK: - Layout properties
    
    private lazy var profilePhoto: UIImageView = {
        let profilePhoto = UIImageView()
        profilePhoto.layer.cornerRadius = 35
        profilePhoto.backgroundColor = .blackDay
        profilePhoto.clipsToBounds = true
        profilePhoto.translatesAutoresizingMaskIntoConstraints = false
        return profilePhoto
    }()
    
    private lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.text = viewModel?.user?.name
        nameLabel.textColor = .blackDay
        nameLabel.font = .boldSystemFont(ofSize: 22)
        nameLabel.minimumScaleFactor = 15
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        return nameLabel
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.text = viewModel?.user?.description
        descriptionLabel.numberOfLines = 10
        descriptionLabel.textColor = .blackDay
        descriptionLabel.font = .systemFont(ofSize: 13, weight: .regular)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        return descriptionLabel
    }()
    
    private lazy var siteButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Go to user site".localized(), for: .normal)
        button.backgroundColor = .systemBackground
        button.setTitleColor(.blackDay, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.layer.cornerRadius = 16
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.blackDay?.cgColor
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(siteButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorColor = .whiteDay
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    //MARK: - LifeCycle
    
    init(viewModel: UserViewModel, indexPath: IndexPath) {
        self.viewModel = viewModel
        self.indexPath = indexPath
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let indexPath else { return }
        viewModel?.startObserve(indexPath: indexPath)
        bind()
        setupUI()
        setupLayout()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard let indexPath else { return }
        viewModel?.startObserve(indexPath: indexPath)
    }
    
    //MARK: - Actions
    
    @objc
    private func siteButtonTapped() {
        guard let viewModel else { return }
        guard let urlString = viewModel.user?.website else { return }
        guard let url = URL(string: urlString) else { return }
        let webViewController = WebViewViewController(url: url)
        navigationController?.pushViewController(webViewController, animated: true)
        
    }
    
    //MARK: - Methods
    
    private func bind() {
        guard let viewModel else {return}
        viewModel.$user.bind {[weak self] user in
            self?.nameLabel.text = user?.name
            self?.descriptionLabel.text = user?.description
            guard let urlString = user?.avatar else { return }
            guard let url = URL(string: urlString) else { return }
            self?.updateAvatar(url: url)
        }
    }
    
    private func updateAvatar(url: URL) {
        let cache = ImageCache.default
        cache.diskStorage.config.expiration = .seconds(1)
        
        let processor = RoundCornerImageProcessor(cornerRadius: 35, backgroundColor: .clear)
        profilePhoto.kf.indicatorType = .activity
        profilePhoto.kf.setImage(with: url,
                                 placeholder: nil,
                                 options: [.processor(processor),
                                           .cacheSerializer(FormatIndicatedCacheSerializer.png)])
    }
    
    private func setupUI() {
        tableView.delegate = self
        tableView.dataSource = self
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.tintColor = .blackDay
        view.backgroundColor = .whiteDay
        view.addSubview(profilePhoto)
        view.addSubview(nameLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(siteButton)
        view.addSubview(tableView)
    }
    
    private func setupLayout() {
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
            
            siteButton.leadingAnchor.constraint(equalTo: profilePhoto.leadingAnchor),
            siteButton.trailingAnchor.constraint(equalTo: descriptionLabel.trailingAnchor),
            siteButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 28),
            siteButton.heightAnchor.constraint(equalToConstant: 40),
            
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.heightAnchor.constraint(equalToConstant: 162),
            tableView.topAnchor.constraint(equalTo: siteButton.bottomAnchor, constant: 40)
        ])
    }
}

extension UserViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let collectionViewController = CollectionViewController()
        navigationController?.pushViewController(collectionViewController, animated: true)
    }
}

extension UserViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        guard let user = viewModel?.user else { return cell}
        cell.textLabel?.text = "\("My NFTs".localized()) (\(user.nfts.count))"
        cell.textLabel?.textColor = .blackDay
        cell.textLabel?.font = .boldSystemFont(ofSize: 17)
        cell.accessoryView = UIImageView(image: UIImage.Icons.forward)
        cell.accessoryView?.tintColor = .blackDay
        cell.backgroundColor = .whiteDay
        cell.selectionStyle = .none
        return cell
    }
    
    
}
