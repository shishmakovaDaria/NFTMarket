//
//  SummaryView.swift
//  FakeNFT
//
//  Created by Vitaly Anpilov on 01.08.2023.
//

import UIKit


final class SummaryView: UIView {
    //MARK: - Layout properties
    private var nftCountLabel: UILabel = {
        let label = UILabel()
        label.font = .caption1
        label.textColor = .blackDay
        label.text = "5 NFT"
        return label
    }()
    
    private var priceLabel: UILabel = {
        let label = UILabel()
        label.font = .bodyBold
        label.textColor = .ypGreen
        label.text = "22 BTC"
        return label
    }()
    
    private var labelsStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 2
        return stack
    }()
    
    private var toPayButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 16
        button.backgroundColor = .blackDay
        button.setTitleColor(.whiteDay, for: .normal)
        button.setTitle("To pay".localized(), for: .normal)
        button.titleLabel?.font = .bodyBold
        button.addTarget(self, action: #selector(didTapToPayButton), for: .touchUpInside)
        return button
    }()
    
    
    // MARK: - LifeCircle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Properties
    
    weak var delegate: SummaryViewDelegate?
    
    // MARK: - Actions
    @objc
    private func didTapToPayButton() {
        delegate?.didTapToPayButton()
    }
    
    //MARK: - Methods
    func configureSummary(with summaryInfo: SummaryInfo) {
        nftCountLabel.text = "\(summaryInfo.countNFT) NFT"
        priceLabel.text = "\(summaryInfo.price) ETH"
    }
    
    private func setView() {
        backgroundColor = .lightGrayDay
        layer.cornerRadius = 12
        layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        [toPayButton, labelsStack].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
        
        labelsStack.addArrangedSubview(nftCountLabel)
        labelsStack.addArrangedSubview(priceLabel)
        
        setConstraints()
    }

    private func setConstraints() {
        NSLayoutConstraint.activate([
            labelsStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            labelsStack.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            labelsStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
         
            toPayButton.leadingAnchor.constraint(equalTo: labelsStack.trailingAnchor, constant: 24),
            toPayButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            toPayButton.centerYAnchor.constraint(equalTo: labelsStack.centerYAnchor),
            toPayButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
}

