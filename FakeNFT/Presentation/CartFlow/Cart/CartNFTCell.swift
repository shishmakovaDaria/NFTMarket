//
//  CartNFTCell.swift
//  FakeNFT
//
//  Created by Vitaly Anpilov on 01.08.2023.
//

import UIKit


final class CartNFTCell: UITableViewCell {
    // MARK: - Layout elements
    private var nftImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 12
        return imageView
    }()
    
    private var ratingImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private let nftLabel: UILabel = {
        let label = UILabel()
        label.font = .bodyBold
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = .caption2
        label.text = "Цена"
        return label
    }()
    
    private let priceValue: UILabel = {
        let label = UILabel()
        label.font = .bodyBold
        return label
    }()
    
    private lazy var deleteButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage.Icons.deleteFromCart, for: .normal)
        button.addTarget(self, action: #selector(didTapRemoveButton), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Properties
    
    weak var delegate: CartNFTCellDelegate?
    private var model: NFTModel?
    
    //MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Actions
    @objc
    private func didTapRemoveButton() {
        guard let model else { return }
        delegate?.didTapDeleteButton(on: model)
    }
    
    //MARK: - Methods
    func configureCell(with model: NFTModel) {
        self.model = model
        nftImageView.image = model.images  // TO DO via Kingfisher
        nftLabel.text = model.name
        priceValue.text = "\(model.price) ETH"
        switch model.rating {
        case 0: ratingImageView.image = UIImage.Icons.zeroStarRating
        case 1: ratingImageView.image = UIImage.Icons.oneStarRating
        case 2: ratingImageView.image = UIImage.Icons.twoStarRating
        case 3: ratingImageView.image = UIImage.Icons.threeStarRating
        case 4: ratingImageView.image = UIImage.Icons.fourStarRating
        case 5: ratingImageView.image = UIImage.Icons.fiveStarRating
        default:
            break
        }

    }
    
    private func setView() {
        contentView.backgroundColor = .whiteDay
        
        [nftImageView, nftLabel, ratingImageView, priceLabel, priceValue, deleteButton]
            .forEach {
                $0.translatesAutoresizingMaskIntoConstraints = false
                contentView.addSubview($0)
            }
        
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            
            nftImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            nftImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            nftImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            nftImageView.widthAnchor.constraint(equalToConstant: 108),
            nftImageView.heightAnchor.constraint(equalToConstant: 108),
           
            nftLabel.leadingAnchor.constraint(equalTo: nftImageView.trailingAnchor, constant: 20),
            nftLabel.topAnchor.constraint(equalTo: nftImageView.topAnchor, constant: 8),
            
            ratingImageView.leadingAnchor.constraint(equalTo: nftLabel.leadingAnchor),
            ratingImageView.topAnchor.constraint(equalTo: nftLabel.bottomAnchor, constant: 4),
        
            priceLabel.leadingAnchor.constraint(equalTo: nftLabel.leadingAnchor),
            priceLabel.bottomAnchor.constraint(equalTo: priceValue.topAnchor, constant: -2),
            
            priceValue.leadingAnchor.constraint(equalTo: nftLabel.leadingAnchor),
            priceValue.bottomAnchor.constraint(equalTo: nftImageView.bottomAnchor, constant: -8),
            
            deleteButton.centerYAnchor.constraint(equalTo: nftImageView.centerYAnchor),
            deleteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
    }
    
}

// MARK: - ReuseIdentifying
extension CartNFTCell: ReuseIdentifying {}
