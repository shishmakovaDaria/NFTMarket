//
//  WebViewVIewController.swift
//  FakeNFT
//
//  Created by Aleksandr Garipov on 04.08.2023.
//

import WebKit

final class WebViewViewController: UIViewController {
    
    let url: URL?
    
    //MARK: -  Layout properties
    
    private lazy var webView: WKWebView = {
        let webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()
    
    // MARK: - LifeCycle
    
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
        setupLayout()
        startLoadPage()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        webView.stopLoading()
    }
    
    // MARK: - Methods:
    
    private func startLoadPage() {
        guard let url else {return}
        let request = URLRequest(url: url)
        webView.load(request)
    }
    
    private func setupUI() {
        view.addSubview(webView)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
