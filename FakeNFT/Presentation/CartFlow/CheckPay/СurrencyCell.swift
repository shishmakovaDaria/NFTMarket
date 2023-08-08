//
//  SelectTypePayCell.swift
//  FakeNFT
//
//  Created by Vitaly Anpilov on 04.08.2023.
//

import UIKit
import Kingfisher

final class CurrencyCell: UICollectionViewCell {
    
    // MARK: - Layout elements
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private let imageBackgroundView: UIView = {
        let view = UIView()
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 6
        view.backgroundColor = .ypBlack
        return view
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .caption2
        label.textColor = .ypGreen
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .caption2
        return label
    }()
    
    private let labelsStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        return stack
    }()
    
    // MARK: - Properties
    var currencyModel: CurrencyModel?
    
    
    // MARK: - Lifecircle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Methods
    func configure(with model: CurrencyModel) {
        currencyModel = model
        
        let urlImage = URL(string: model.image)
        imageView.kf.setImage(with: urlImage)
        titleLabel.text = model.title
        nameLabel.text = model.name
    }
    
    func select() {
        contentView.layer.borderColor = UIColor.black.cgColor
        contentView.layer.borderWidth = 1
    }
    
    func deselect() {
        contentView.layer.borderWidth = 0
    }
    
    
    // MARK: - Layout methods
    
    func setView() {
        contentView.layer.masksToBounds = true
        contentView.layer.cornerRadius = 12
        contentView.backgroundColor = .lightGrayDay
        
        [imageBackgroundView, imageView, labelsStackView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
        
        labelsStackView.addArrangedSubview(titleLabel)
        labelsStackView.addArrangedSubview(nameLabel)
        
        setConstraints()
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            imageBackgroundView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            imageBackgroundView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            imageBackgroundView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            imageBackgroundView.widthAnchor.constraint(equalToConstant: 36),
            imageBackgroundView.heightAnchor.constraint(equalToConstant: 36),
            
            imageView.centerXAnchor.constraint(equalTo: imageBackgroundView.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: imageBackgroundView.centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 31.5),
            imageView.heightAnchor.constraint(equalToConstant: 31.5),
            
            labelsStackView.centerYAnchor.constraint(equalTo: imageBackgroundView.centerYAnchor),
            labelsStackView.leadingAnchor.constraint(equalTo: imageBackgroundView.trailingAnchor, constant: 4)
        ])
    }
}


// MARK: - ReuseIdentifying
extension CurrencyCell: ReuseIdentifying {}
