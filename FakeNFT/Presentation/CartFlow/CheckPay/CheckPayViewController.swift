//
//  SelectTypePayViewController.swift
//  FakeNFT
//
//  Created by Vitaly Anpilov on 04.08.2023.
//

import UIKit

final class CheckPayViewController: UIViewController {
    //MARK: - Layout properties
    private lazy var backButton = UIBarButtonItem(
        image: UIImage.Icons.backward,
        style: .plain,
        target: self,
        action: #selector(didTapBackButton)
    )
    
//    private lazy var currenciesCollection: UICollectionView = {
//        let collection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
//        collection.register(CurrencyCell.self, forCellWithReuseIdentifier: CurrencyCell.reuseIdentifier)
//        collection.backgroundColor = .clear
//
//        return collection
//    }()
    
    private var payView: PayView = {
        let view = PayView()
        
        return view
    }()
    
    
    
    // MARK: - Properties
    var viewModel: CheckPayViewModel?
    
    
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
        
//        currenciesCollection.dataSource = self
//        currenciesCollection.delegate = self
        
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
//            self?.currenciesCollection.reloadData()
        }
        
    }
    
    
    
    private func setLayout() {
        view.backgroundColor = .whiteDay
        
        [/*currenciesCollection,*/ payView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        setNavBar()
        setConstraints()
    }
    
    private func setNavBar() {
        title = "Выберите способ оплаты"
        navigationItem.leftBarButtonItem = backButton
       
        navigationController?.navigationBar.tintColor = .blackDay
        navigationController?.navigationBar.backgroundColor = .whiteDay
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            payView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            payView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            payView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
//            currenciesCollection.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
//            currenciesCollection.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
//            currenciesCollection.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
//            currenciesCollection.bottomAnchor.constraint(equalTo: payView.topAnchor)
            
        ])
    }
}
//
////MARK: - UICollectionViewDataSource
//extension CheckPayViewController: UICollectionViewDataSource {
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        viewModel?.currencies.count ?? 0
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell: CurrencyCell = collectionView.dequeueReusableCell(indexPath: indexPath)
//
//        return cell
//    }
//
//}
//
//
////MARK: - UICollectionViewDataSource
//extension CheckPayViewController: UICollectionViewDelegateFlowLayout {
//
//}




