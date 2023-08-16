//
//  FavoriteNFTsViewController.swift
//  FakeNFT
//
//  Created by Дарья Шишмакова on 02.08.2023.
//

import UIKit

final class FavoriteNFTsViewController: UIViewController {
    
    private var viewModel: FavoriteNFTsViewModelProtocol
    
    init(viewModel: FavoriteNFTsViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var placeholder: UILabel = {
        let placeholder = UILabel()
        placeholder.text = "You don't have any favorite NFTs yet".localized()
        placeholder.textColor = .blackDay
        placeholder.font = .bodyBold
        return placeholder
    }()
    
    //TODO: - add collection
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        bind()
        //tableView.dataSource = self
        //tableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.updateNFTs()
        reloadPlaceholder()
    }
    
    private func reloadPlaceholder() {
        if viewModel.nfts.count == 0 {
            placeholder.isHidden = false
            navigationItem.title = ""
            //tableView.isHidden = true
        } else {
            placeholder.isHidden = true
            navigationItem.title = "Favorite NFTs".localized()
            //tableView.isHidden = false
        }
    }
    
    private func bind() {
        viewModel.nftsObservable.bind() { [weak self] _ in
            //self?.tableView.reloadData()
            self?.reloadPlaceholder()
        }
        
        viewModel.likesObservable.bind() { [weak self] _ in
            //self?.tableView.reloadData()
        }
        
        viewModel.isLoadingObservable.bind() { isLoading in
            if isLoading {
                UIBlockingProgressHUD.show()
            } else {
                UIBlockingProgressHUD.dismiss()
            }
        }
    }
    
    private func setupUI() {
        view.backgroundColor = .whiteDay
        navigationController?.navigationBar.topItem?.backButtonTitle = ""
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.tintColor = .blackDay
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        
        [placeholder, /*tableView*/].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            placeholder.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            placeholder.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            
        ])
    }
}
