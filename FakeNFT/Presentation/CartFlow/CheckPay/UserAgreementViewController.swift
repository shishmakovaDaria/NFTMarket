//
//  UserAgreementViewController.swift
//  FakeNFT
//
//  Created by Vitaly Anpilov on 07.08.2023.
//

import UIKit
import WebKit

final class UserAgreementViewController: UIViewController {
    // MARK: - Layout elements
    
    private let webView = WKWebView()
    private lazy var backButton = UIBarButtonItem(
        image: UIImage.Icons.backward,
        style: .plain,
        target: self,
        action: #selector(didTapBackButton)
    )
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        loadPage()
    }
    
    // MARK: - Actions
    @objc
    private func didTapBackButton() {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Methods
    private func loadPage() {
        let request = URLRequest(url: Constants.userAgreementUrl)
        webView.load(request)
    }
    
    func setView() {
        view.backgroundColor = .whiteDay
        
        [webView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        setNavBar()
        setConstraints()
    }
    
    func setNavBar() {
        navigationController?.navigationBar.barTintColor = .whiteDay
        navigationItem.leftBarButtonItem = backButton
        navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            webView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            webView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            webView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
}

// MARK: - UIGestureRecognizerDelegate

extension UserAgreementViewController: UIGestureRecognizerDelegate {}
