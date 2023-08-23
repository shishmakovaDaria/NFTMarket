//
//  PayView.swift
//  FakeNFT
//
//  Created by Vitaly Anpilov on 04.08.2023.
//

import UIKit


final class PayView: UIView, UITextViewDelegate {
    
    //MARK: - Layout properties
    
    private lazy var userAgreementTextView: UITextView = {
        let textView = UITextView()
        textView.font = .caption2
        textView.textColor = .blackDay
        textView.backgroundColor = .clear
        textView.isEditable = false
        textView.isScrollEnabled = false
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 4
        
        let fullText = "Agree purchase".localized() + " " + "User Agreement".localized()
        let attributedString = NSMutableAttributedString(string: fullText)
        
        // диапазон текста, который должен быть гиперссылкой
        let agreementRange = (fullText as NSString).range(of: "User Agreement".localized())
        
        // атрибуты для гиперссылки
        attributedString.addAttribute(
            .foregroundColor,
            value: UIColor.ypBlue!,
            range: agreementRange
        )
        attributedString.addAttribute(
            .paragraphStyle,
            value: paragraphStyle,
            range: NSRange(location: 0, length: attributedString.length)
        )
        textView.addGestureRecognizer(
            UITapGestureRecognizer(target: self,
                                   action: #selector(didTapUserAgreementLink))
        )
        
        textView.attributedText = attributedString
        textView.isUserInteractionEnabled = true
        textView.delegate = self
        
        return textView
    }()
    
    private lazy var payButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 16
        button.backgroundColor = .blackDay
        button.setTitleColor(.whiteDay, for: .normal)
        button.setTitle("Pay".localized(), for: .normal)
        button.titleLabel?.font = .bodyBold
        button.isEnabled = false
        button.addTarget(
            self,
            action: #selector(didTapPayButton), for: .touchUpInside
        )
        return button
    }()
    
    // MARK: - Properties
    
    weak var delegate: PayViewDelegate?
    
    // MARK: - LifeCycle
    
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
        delegate?.didTapPayButton()
    }
    
    @objc
    private func didTapUserAgreementLink(sender: UIGestureRecognizer) {
        delegate?.didTapUserAgreementLink()
    }
        
    // MARK: - Methods
    
    func enablePayButton() {
        payButton.isEnabled = true
    }
    
    private func setView() {
        backgroundColor = .lightGrayDay
        layer.cornerRadius = 12
        layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        [payButton, userAgreementTextView].forEach {
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
            
            userAgreementTextView.leadingAnchor.constraint(equalTo: payButton.leadingAnchor),
            userAgreementTextView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            userAgreementTextView.trailingAnchor.constraint(equalTo: payButton.trailingAnchor),
            userAgreementTextView.bottomAnchor.constraint(equalTo: payButton.topAnchor, constant: -16)
        ])
    }
}
