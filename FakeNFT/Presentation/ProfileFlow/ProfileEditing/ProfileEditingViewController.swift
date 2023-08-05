//
//  ProfileEditingViewController.swift
//  FakeNFT
//
//  Created by Дарья Шишмакова on 01.08.2023.
//

import UIKit

final class ProfileEditingViewController: UIViewController {
    
    private var viewModel: ProfileEditingViewModel?
    
    init(viewModel: ProfileEditingViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        viewModel?.viewDismiss()
    }
    
    private lazy var closeButton: UIButton = {
        let closeButton = UIButton(type: .system)
        closeButton.setBackgroundImage(UIImage.Icons.close, for: .normal)
        closeButton.addTarget(self, action: #selector(closeButtonDidTap(_:)), for: .touchUpInside)
        return closeButton
    }()
    
    private lazy var profilePhoto: UIImageView = {
        let profilePhoto = UIImageView()
        profilePhoto.layer.cornerRadius = 35
        profilePhoto.backgroundColor = .blackDay
        profilePhoto.clipsToBounds = true
        return profilePhoto
    }()
    
    private lazy var changeAvatarButton: UIButton = {
        let changeAvatarButton = UIButton(type: .system)
        changeAvatarButton.backgroundColor = .blackDay?.withAlphaComponent(0.6)
        changeAvatarButton.layer.cornerRadius = 35
        changeAvatarButton.setTitle("Сменить фото", for: .normal)
        changeAvatarButton.titleLabel?.numberOfLines = 2
        changeAvatarButton.titleLabel?.textAlignment = .center
        changeAvatarButton.tintColor = .ypWhite
        changeAvatarButton.titleLabel?.font = .systemFont(ofSize: 10, weight: .medium)
        changeAvatarButton.addTarget(self, action: #selector(changeAvatarButtonDidTap(_:)), for: .touchUpInside)
        return changeAvatarButton
    }()
    
    private lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.text = "Name".localized()
        nameLabel.textColor = .blackDay
        nameLabel.font = .boldSystemFont(ofSize: 22)
        return nameLabel
    }()
    
    private lazy var nameTextField: ProfileTextField = {
        let nameTextField = ProfileTextField()
        nameTextField.text = viewModel?.profile.name
        nameTextField.textColor = .blackDay
        nameTextField.font = .systemFont(ofSize: 17, weight: .regular)
        nameTextField.backgroundColor = .lightGrayDay
        nameTextField.layer.cornerRadius = 12
        nameTextField.clearButtonMode = .whileEditing
        nameTextField.returnKeyType = .default
        nameTextField.delegate = self
        return nameTextField
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.text = "Description".localized()
        descriptionLabel.textColor = .blackDay
        descriptionLabel.font = .boldSystemFont(ofSize: 22)
        return descriptionLabel
    }()
    
    private lazy var descriptionTextField: UITextView = {
        //настроить отступы текста, измнение высоты в зависимости от текста
        let descriptionTextField = UITextView()
        descriptionTextField.text = viewModel?.profile.description
        descriptionTextField.textColor = .blackDay
        descriptionTextField.font = .systemFont(ofSize: 17, weight: .regular)
        descriptionTextField.backgroundColor = .lightGrayDay
        descriptionTextField.layer.cornerRadius = 12
        descriptionTextField.isScrollEnabled = true
        //descriptionTextField.clearButtonMode = .whileEditing
        descriptionTextField.returnKeyType = .default
        //categoryName.delegate = self
        return descriptionTextField
    }()
    
    private lazy var websiteLabel: UILabel = {
        let websiteLabel = UILabel()
        websiteLabel.text = "Website".localized()
        websiteLabel.textColor = .blackDay
        websiteLabel.font = .boldSystemFont(ofSize: 22)
        return websiteLabel
    }()
    
    private lazy var websiteTextField: ProfileTextField = {
        let websiteTextField = ProfileTextField()
        websiteTextField.text = viewModel?.profile.website
        websiteTextField.textColor = .blackDay
        websiteTextField.font = .systemFont(ofSize: 17, weight: .regular)
        websiteTextField.backgroundColor = .lightGrayDay
        websiteTextField.layer.cornerRadius = 12
        websiteTextField.clearButtonMode = .whileEditing
        websiteTextField.returnKeyType = .default
        websiteTextField.delegate = self
        return websiteTextField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .whiteDay
        setupUI()
        setupConstraints()
    }
    
    func setProfilePhoto(imageToSet: UIImage) {
        profilePhoto.image = imageToSet
    }
    
    @objc private func closeButtonDidTap(_ sender: Any?) {
        dismiss(animated: true)
    }
    
    @objc private func changeAvatarButtonDidTap(_ sender: Any?) {
        // to do
    }
    
    private func setupUI() {
        view.addSubview(closeButton)
        view.addSubview(profilePhoto)
        view.addSubview(changeAvatarButton)
        view.addSubview(nameLabel)
        view.addSubview(nameTextField)
        view.addSubview(descriptionLabel)
        view.addSubview(descriptionTextField)
        view.addSubview(websiteLabel)
        view.addSubview(websiteTextField)
        
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        profilePhoto.translatesAutoresizingMaskIntoConstraints = false
        changeAvatarButton.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionTextField.translatesAutoresizingMaskIntoConstraints = false
        websiteLabel.translatesAutoresizingMaskIntoConstraints = false
        websiteTextField.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 24),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            
            profilePhoto.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profilePhoto.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
            profilePhoto.heightAnchor.constraint(equalToConstant: 70),
            profilePhoto.widthAnchor.constraint(equalToConstant: 70),
            
            changeAvatarButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            changeAvatarButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
            changeAvatarButton.heightAnchor.constraint(equalToConstant: 70),
            changeAvatarButton.widthAnchor.constraint(equalToConstant: 70),
            
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            nameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 174),
            
            nameTextField.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            nameTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            nameTextField.heightAnchor.constraint(equalToConstant: 44),
            
            descriptionLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 24),
            
            descriptionTextField.leadingAnchor.constraint(equalTo: descriptionLabel.leadingAnchor),
            descriptionTextField.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 8),
            descriptionTextField.trailingAnchor.constraint(equalTo: nameTextField.trailingAnchor),
            descriptionTextField.heightAnchor.constraint(equalToConstant: 132),
            
            websiteLabel.leadingAnchor.constraint(equalTo: descriptionLabel.leadingAnchor),
            websiteLabel.topAnchor.constraint(equalTo: descriptionTextField.bottomAnchor, constant: 24),
            
            websiteTextField.leadingAnchor.constraint(equalTo: nameTextField.leadingAnchor),
            websiteTextField.trailingAnchor.constraint(equalTo: nameTextField.trailingAnchor),
            websiteTextField.topAnchor.constraint(equalTo: websiteLabel.bottomAnchor, constant: 8),
            websiteTextField.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
}

//MARK: - UITextFieldDelegate
extension ProfileEditingViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        if let text = nameTextField.text {
            viewModel?.changeProfileName(nameToSet: text)
        }
        
        return true
    }
}
