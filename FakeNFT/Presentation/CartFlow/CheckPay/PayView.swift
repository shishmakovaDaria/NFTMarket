//
//  PayView.swift
//  FakeNFT
//
//  Created by Vitaly Anpilov on 04.08.2023.
//

import UIKit

final class PayView: UIView {
    //MARK: - Layout properties
    
    private lazy var userAgreementLabel: UILabel = {
        let label = UILabel()
        label.font = .caption2
        label.numberOfLines = 2
        let fullText = "Совершая покупку, вы соглашаетесь с условиями Пользовательского соглашения"
        let attributedText = NSMutableAttributedString(string: fullText)
        
        // Определите диапазон текста, который должен быть другого цвета
        let colorRange = (fullText as NSString).range(of: "Пользовательским соглашением")
        attributedText.addAttribute(.foregroundColor, value: UIColor.ypBlue!, range: colorRange)
        
        label.attributedText = attributedText
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapUserAgreementLink)))
        return label
    }()
    
    private lazy var payButton: UIButton = {
        let button = UIButton()
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 16
        button.backgroundColor = .blackDay
        button.setTitleColor(.whiteDay, for: .normal)
        button.setTitle("Pay".localized(), for: .normal)
        button.titleLabel?.font = .bodyBold
        button.addTarget(PayView.self, action: #selector(didTapPayButton), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Properties

    weak var delegate: PayViewDelegate?
    
    // MARK: - LifeCircle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Actions
    
    @objc
    private func didTapPayButton() {
        
    }
    
    @objc
    private func didTapUserAgreementLink(sender: UIGestureRecognizer) {
        
    }
    
    
    // MARK: - Methods
    
    
    
    private func setView() {
        backgroundColor = .lightGrayDay
        layer.cornerRadius = 12
        layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        [payButton, userAgreementLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
        
        setConstraints()
    }
    
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            payButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            payButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            payButton.bottomAnchor.constraint(equalTo: bottomAnchor),
            payButton.heightAnchor.constraint(equalToConstant: 60),
        
            userAgreementLabel.leadingAnchor.constraint(equalTo: payButton.leadingAnchor),
            userAgreementLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            userAgreementLabel.trailingAnchor.constraint(equalTo: payButton.trailingAnchor),
            userAgreementLabel.bottomAnchor.constraint(equalTo: payButton.topAnchor, constant: -16)
        ])
    }
}
