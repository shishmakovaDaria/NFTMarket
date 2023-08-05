//
//  PayView.swift
//  FakeNFT
//
//  Created by Vitaly Anpilov on 04.08.2023.
//

import UIKit

final class PayView: UIView {
    //MARK: - Layout properties
    
    private lazy var userAgreementText: UITextView = {
        let view = UITextView()
        view.font = .caption2
        view.textColor = .blackDay
        let fullText = "Совершая покупку, вы соглашаетесь с условиями Пользовательского соглашения"
        let attributedText = NSMutableAttributedString(string: fullText)
        
        //  диапазон текста, который должен быть другого цвета
        let agreementRange = (fullText as NSString).range(of: "Пользовательского соглашения")
        attributedText.addAttribute(.foregroundColor, value: UIColor.ypBlue as Any, range: agreementRange)
        view.text = fullText
        view.attributedText = attributedText
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapUserAgreementLink)))
        return view
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
        
        [payButton, userAgreementText].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
        
        setConstraints()
    }
    
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            userAgreementText.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            userAgreementText.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 16),
            userAgreementText.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            
            payButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            payButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            payButton.topAnchor.constraint(equalTo: userAgreementText.bottomAnchor, constant: 16),
            payButton.heightAnchor.constraint(equalToConstant: 60),
           
        ])
    }
}
