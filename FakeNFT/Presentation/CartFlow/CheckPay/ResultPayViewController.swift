//
//  ResultPayViewController.swift
//  FakeNFT
//
//  Created by Vitaly Anpilov on 08.08.2023.
//

import UIKit

final class ResultPayViewController: UIViewController {
    
    //MARK: - Layout properties
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 12
        return imageView
    }()
    
    private lazy var alertLabel: UILabel = {
        let label = UILabel()
        label.font = .headline3
        label.textColor = .blackDay
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 20
        stack.distribution = .fillEqually
        return stack
    }()
    
    private lazy var returnButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 16
        button.backgroundColor = .blackDay
        button.setTitleColor(.whiteDay, for: .normal)
        button.titleLabel?.font = .bodyBold
        button.addTarget(
            self,
            action: #selector(didTapReturnButton),
            for: .touchUpInside
        )
        return button
    }()
    
    // MARK: - Properties
    
    var isSuccess: Bool?
      
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setView()
    }
    
    // MARK: - Actions
    
    @objc
    private func didTapReturnButton() {
        if isSuccess! {
            navigationController?.popToRootViewController(animated: false)
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
    
    //MARK: - Methods
    
    func setView() {
        view.backgroundColor = .whiteDay
        
        [stackView, returnButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        if isSuccess! {
            alertLabel.text = "Success! Payment completed, congratulations on your purchase!".localized()
            imageView.image = UIImage.Images.successPayImage
            returnButton.setTitle("Back to catalog".localized(), for: .normal)
        } else {
            alertLabel.text = "Oops! Something went wrong :( Try again!".localized()
            imageView.image = UIImage.Images.failurePayImage
            returnButton.setTitle("Try again".localized(), for: .normal)
        }
        
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(alertLabel)
        
        setNavBar()
        setConstraints()
    }
    
    private func setNavBar() {
        navigationItem.hidesBackButton = true
        navigationController?.navigationBar.backgroundColor = .clear
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            imageView.widthAnchor.constraint(equalToConstant: 278),
            imageView.heightAnchor.constraint(equalToConstant: 278),
            
            returnButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            returnButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            returnButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            returnButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
}
