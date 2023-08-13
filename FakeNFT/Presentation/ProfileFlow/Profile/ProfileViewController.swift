//
//  ProfileViewController.swift
//  FakeNFT
//
//  Created by Aleksandr Garipov on 30.07.2023.
//

import UIKit
import Kingfisher
import ProgressHUD

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
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isScrollEnabled = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var scrollContainer: UIView = {
        let scrollContainer = UIView()
        scrollContainer.translatesAutoresizingMaskIntoConstraints = false
        return scrollContainer
    }()
    
    private lazy var profilePhoto: UIImageView = {
        let profilePhoto = UIImageView()
        profilePhoto.layer.cornerRadius = 35
        profilePhoto.contentMode = .scaleAspectFill
        profilePhoto.backgroundColor = .blackDay
        profilePhoto.clipsToBounds = true
        return profilePhoto
    }()
    
    private lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.text = viewModel?.profile.name
        nameLabel.textColor = .blackDay
        nameLabel.font = .headline3
        nameLabel.minimumScaleFactor = 15
        return nameLabel
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.text = viewModel?.profile.description
        descriptionLabel.numberOfLines = 200
        descriptionLabel.textColor = .blackDay
        descriptionLabel.font = .caption2
        return descriptionLabel
    }()
    
    private lazy var profileWebsite: UILabel = {
        let profileWebsite = UILabel()
        profileWebsite.text = viewModel?.profile.website
        profileWebsite.textColor = .ypBlue
        profileWebsite.font = .caption1
        return profileWebsite
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = 54
        tableView.separatorColor = .whiteDay
        tableView.backgroundColor = .whiteDay
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        bind()
        updateAvatar()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIBlockingProgressHUD.show()
        viewModel?.updateProfile()
    }
    
    @objc private func editButtonDidTap(_ sender: Any?) {
        let profileEditingViewModel = ProfileEditingViewModel()
        guard let viewModel = viewModel else { return }
        profileEditingViewModel.updateProfile(profileToSet: viewModel.profile)
        let vc = ProfileEditingViewController(viewModel: profileEditingViewModel)
        profileEditingViewModel.delegate = viewModel
        vc.setProfilePhoto(imageToSet: profilePhoto.image ?? UIImage())
        present(vc, animated: true)
    }
    
    private func updateAvatar() {
        guard let url = viewModel?.provideAvatarURL() else { return }
        let cache = ImageCache.default
        cache.diskStorage.config.expiration = .days(1)
        
        let processor = RoundCornerImageProcessor(cornerRadius: 35, backgroundColor: .clear)
        profilePhoto.kf.indicatorType = .activity
        profilePhoto.kf.setImage(with: url,
                                 placeholder: nil,
                                 options: [.processor(processor),
                                           .cacheSerializer(FormatIndicatedCacheSerializer.png)])
    }
    
    private func bind() {
        viewModel?.$profile.bind { [weak self] _ in
            self?.nameLabel.text = self?.viewModel?.profile.name
            self?.descriptionLabel.text = self?.viewModel?.profile.description
            self?.profileWebsite.text = self?.viewModel?.profile.website
            self?.updateAvatar()
            self?.tableView.reloadData()
            UIBlockingProgressHUD.dismiss()
        }
    }
    
    private func setupUI() {
        view.backgroundColor = .whiteDay
        navigationController?.navigationBar.barTintColor = .whiteDay
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: editButton)
        view.addSubview(scrollView)
        scrollView.addSubview(scrollContainer)
        
        [profilePhoto, nameLabel, descriptionLabel, profileWebsite, tableView].forEach {
            scrollContainer.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func setupConstraints() {
        let scrollContentGuide = scrollView.contentLayoutGuide
        let scrollFrameLayoutGuide = scrollView.frameLayoutGuide
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            scrollContainer.leadingAnchor.constraint(equalTo: scrollContentGuide.leadingAnchor),
            scrollContainer.trailingAnchor.constraint(equalTo: scrollContentGuide.trailingAnchor),
            scrollContainer.topAnchor.constraint(equalTo: scrollContentGuide.topAnchor),
            scrollContainer.bottomAnchor.constraint(equalTo: scrollContentGuide.bottomAnchor),
            
            scrollContainer.leadingAnchor.constraint(equalTo: scrollFrameLayoutGuide.leadingAnchor),
            scrollContainer.trailingAnchor.constraint(equalTo: scrollFrameLayoutGuide.trailingAnchor),
            
            profilePhoto.leadingAnchor.constraint(equalTo: scrollContainer.leadingAnchor, constant: 16),
            profilePhoto.topAnchor.constraint(equalTo: scrollContainer.topAnchor, constant: 20),
            profilePhoto.heightAnchor.constraint(equalToConstant: 70),
            profilePhoto.widthAnchor.constraint(equalToConstant: 70),
            
            nameLabel.leadingAnchor.constraint(equalTo: profilePhoto.trailingAnchor, constant: 16),
            nameLabel.centerYAnchor.constraint(equalTo: profilePhoto.centerYAnchor),
            
            descriptionLabel.leadingAnchor.constraint(equalTo: profilePhoto.leadingAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: profilePhoto.bottomAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: scrollContainer.trailingAnchor, constant: -18),
            
            profileWebsite.leadingAnchor.constraint(equalTo: profilePhoto.leadingAnchor),
            profileWebsite.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 12),
            
            tableView.leadingAnchor.constraint(equalTo: scrollContainer.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: scrollContainer.trailingAnchor),
            tableView.heightAnchor.constraint(equalToConstant: 162),
            tableView.topAnchor.constraint(equalTo: profileWebsite.bottomAnchor, constant: 40),
            tableView.bottomAnchor.constraint(equalTo: scrollContainer.bottomAnchor, constant: -15)
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
        cell.textLabel?.font = .bodyBold
        cell.accessoryView = UIImageView(image: UIImage.Icons.forward)
        cell.accessoryView?.tintColor = .blackDay
        cell.backgroundColor = .whiteDay
        
        return cell
    }
}

//MARK: - UITableViewDelegate
extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row == 0 {
            let myNFTsViewModel = MyNFTsViewModel()
            let vc = MyNFTsViewController(viewModel: myNFTsViewModel)
            myNFTsViewModel.nftIDs = viewModel?.profile.nfts ?? []
            vc.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(vc, animated: true)
        }
        if indexPath.row == 1 {
            let vc = FavoriteNFTsViewController()
            vc.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(vc, animated: true)
        }
        if indexPath.row == 2 {
            guard let url = viewModel?.provideWebsiteURL() else { return }
            let vc = ProfileWebsiteViewController(url: url)
            vc.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
