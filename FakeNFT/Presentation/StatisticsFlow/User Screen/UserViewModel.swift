//
//  UserViewModel.swift
//  FakeNFT
//
//  Created by Aleksandr Garipov on 03.08.2023.
//

import UIKit
import Kingfisher

final class UserViewModel: UserViewModelProtocol {
    // MARK: - Observables
    @Observable
    private (set) var user: UserModel
    var userObservable: Observable<UserModel> { $user }
    //MARK: - LifeCycle
    
    init(user: UserModel) {
        self.user = user
    }
    
    // MARK: - Methods
    
    func updateAvatar(for imageView: UIImageView) {
        guard let url = URL(string: user.avatar) else {
            return
        }
        
        let cache = ImageCache.default
        cache.diskStorage.config.expiration = .seconds(1)
        
        let processor = RoundCornerImageProcessor(cornerRadius: 35, backgroundColor: .clear)
        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(with: url,
                                 placeholder: nil,
                                 options: [.processor(processor),
                                           .cacheSerializer(FormatIndicatedCacheSerializer.png)])
    }
}
