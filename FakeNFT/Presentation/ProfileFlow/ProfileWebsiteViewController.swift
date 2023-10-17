//
//  ProfileWebsiteViewController.swift
//  FakeNFT
//
//  Created by Дарья Шишмакова on 02.08.2023.
//

import UIKit
import WebKit

final class ProfileWebsiteViewController: UIViewController {
    
    //MARK: - Layout properties
    private lazy var webView: WKWebView = {
        let webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()
    
    //MARK: - Properties
    private let url: URL
    
    //MARK: - LifeCycle
    init(url: URL) {
        self.url = url
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        webView.load(URLRequest(url: url))
    }
    
    //MARK: - Methods
    private func setupUI() {
        view.backgroundColor = .whiteDay
        navigationController?.navigationBar.topItem?.title = ""
        navigationController?.navigationBar.tintColor = .blackDay
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        view.addSubview(webView)
        
        NSLayoutConstraint.activate([
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
