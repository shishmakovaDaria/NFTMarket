//
//  SelectTypePayViewController.swift
//  FakeNFT
//
//  Created by Vitaly Anpilov on 04.08.2023.
//

import UIKit

final class CheckPayViewController: UIViewController {
    //MARK: - Layout properties
    private lazy var navBarTitle: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "Select a Payment Method".localized()
        titleLabel.textColor = .blackDay
        titleLabel.font = .bodyBold
        titleLabel.sizeToFit()
        return titleLabel
    }()
    
    private lazy var backButton = UIBarButtonItem(
        image: UIImage.Icons.backward,
        style: .plain,
        target: self,
        action: #selector(didTapBackButton)
    )
    
    private lazy var currenciesCollection: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collection.register(CurrencyCell.self, forCellWithReuseIdentifier: CurrencyCell.reuseIdentifier)
        collection.backgroundColor = .clear

        return collection
    }()
    
    private lazy var payView: PayView = {
        let view = PayView()
        view.delegate = self
        return view
    }()
    
    
    // MARK: - Properties
    var viewModel: CheckPayViewModel?
    private let collectionParams = UICollectionView.CollectionParams(
        cellCount: 2,
        leftInset: 16,
        rightInset: 16,
        topInset: 0,
        bottomInset: 0,
        height: 46,
        cellSpacing: 8
    )
        
    
    //MARK: - LifeCircle
    init(viewModel: CheckPayViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currenciesCollection.dataSource = self
        currenciesCollection.delegate = self
        
        bind()
        setLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel?.startObserve()
    }
    
    
    //MARK: - Actions
    @objc
    private func didTapBackButton() {
        navigationController?.popViewController(animated: true)
    }
    
    
    //MARK: - Methods
    private func bind() {
        viewModel?.$currencies.bind { [weak self] _ in
            self?.currenciesCollection.reloadData()
        }
        
    }
    
    private func setLayout() {
        view.backgroundColor = .whiteDay
       
        [currenciesCollection, payView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        setNavBar()
        setConstraints()
    }
    
    private func setNavBar() {
        navigationItem.titleView = navBarTitle
        navigationItem.leftBarButtonItem = backButton
        navigationController?.navigationBar.tintColor = .blackDay
        navigationController?.navigationBar.backgroundColor = .whiteDay
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            payView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            payView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            payView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            currenciesCollection.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            currenciesCollection.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            currenciesCollection.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            currenciesCollection.bottomAnchor.constraint(equalTo: payView.topAnchor)
            
        ])
    }
}

//MARK: - UICollectionViewDataSource
extension CheckPayViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel?.currencies.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CurrencyCell = collectionView.dequeueReusableCell(indexPath: indexPath)
        if let model = viewModel?.currencies[indexPath.row] {
            cell.configure(with: model)
        }
        return cell
    }

}


//MARK: - UICollectionViewDelegateFlowLayout
extension CheckPayViewController: UICollectionViewDelegateFlowLayout {
    
    // selecting methods
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell: CurrencyCell = collectionView.cellForItem(at: indexPath) as! CurrencyCell
        
        cell.select()
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell: CurrencyCell = collectionView.cellForItem(at: indexPath) as! CurrencyCell
        
        cell.deselect()
    }
    
    // params methods
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let availableSpace = collectionView.frame.width - collectionParams.paddingWidth
        let cellWidth = availableSpace / collectionParams.cellCount
        return CGSize(width: cellWidth, height: collectionParams.height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        UIEdgeInsets(
            top: collectionParams.topInset,
            left: collectionParams.leftInset,
            bottom: collectionParams.bottomInset,
            right: collectionParams.rightInset
        )
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int
    ) -> CGFloat {
        collectionParams.cellSpacing
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        collectionParams.cellSpacing
    }
}


// MARK: - PayViewDelegate
extension CheckPayViewController: PayViewDelegate {
    func didTapPayButton() {
        
    }

    func didTapUserAgreementLink() {
        
    }
}




