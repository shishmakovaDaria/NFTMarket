//
//  DeleteNFTViewController.swift
//  FakeNFT
//
//  Created by Vitaly Anpilov on 03.08.2023.
//

import UIKit

final class DeleteFromCartViewController: UIViewController {
    
    //MARK: - Layout properties
    
    private lazy var blurView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return blurEffectView
    }()
    
    private let nftImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 12
        return imageView
    }()
    
    private lazy var alertLabel: UILabel = {
        let label = UILabel()
        label.font = .caption2
        label.textColor = .blackDay
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = "Вы уверены, что хотите удалить объект из корзины?"
        return label
    }()
    
    private lazy var buttonsStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 8
        stack.distribution = .fillEqually
        return stack
    }()
    
    private lazy var deleteButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .blackDay
        button.setTitle("Delete".localized(), for: .normal)
        button.titleLabel?.font = .bodyRegular
        button.setTitleColor(.ypRed, for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 16
        button.addTarget(self, action: #selector(didTapDeleteButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var returnButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.whiteDay, for: .normal)
        button.backgroundColor = .blackDay
        button.setTitle("Back".localized(), for: .normal)
        button.titleLabel?.font = .bodyRegular
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 16
        button.addTarget(self, action: #selector(didTapReturnButton), for: .touchUpInside)
        return button
    }()

    
    // MARK: - Properties
     var NFTforDelete: NFTModel?
    
    
    //MARK: - LifeCircle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setView()
        nftImageView.image = NFTforDelete?.images
    }
    
    // MARK: - Actions

    @objc
    private func didTapReturnButton() {
        dismiss(animated: true)
    }

    @objc
    private func didTapDeleteButton() {
        
    }
    
    
    //MARK: - Methods
    func setView() {
        [blurView, nftImageView, alertLabel, buttonsStackView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        buttonsStackView.addArrangedSubview(deleteButton)
        buttonsStackView.addArrangedSubview(returnButton)
        
        setConstraints()
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            // nftImageView
            nftImageView.centerXAnchor.constraint(equalTo: alertLabel.centerXAnchor),
            nftImageView.bottomAnchor.constraint(equalTo: alertLabel.topAnchor, constant: -12),
            nftImageView.widthAnchor.constraint(equalToConstant: 108),
            nftImageView.heightAnchor.constraint(equalToConstant: 108),
            // alertLabel
            alertLabel.widthAnchor.constraint(equalToConstant: 180),
            alertLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            alertLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            // buttonsStackView
            buttonsStackView.centerXAnchor.constraint(equalTo: alertLabel.centerXAnchor),
            buttonsStackView.topAnchor.constraint(equalTo: alertLabel.bottomAnchor, constant: 20),
            buttonsStackView.widthAnchor.constraint(equalToConstant: 262),
            buttonsStackView.heightAnchor.constraint(equalToConstant: 44)
        ])
    }

}
