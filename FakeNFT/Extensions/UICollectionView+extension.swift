//
//  UICollectionView+extension.swift
//  FakeNFT
//
//  Created by Vitaly Anpilov on 08.08.2023.
//

import UIKit

extension UICollectionView {
    
    struct CollectionParams {
        let cellCount: CGFloat
        let leftInset: CGFloat
        let rightInset: CGFloat
        let topInset: CGFloat
        let bottomInset: CGFloat
        let height: CGFloat
        let cellSpacing: CGFloat
        let paddingWidth: CGFloat
        
        init(cellCount: CGFloat, leftInset: CGFloat, rightInset: CGFloat, topInset: CGFloat, bottomInset:CGFloat, height: CGFloat,  cellSpacing: CGFloat) {
            self.cellCount = cellCount
            self.leftInset = leftInset
            self.rightInset = rightInset
            self.topInset = topInset
            self.bottomInset = bottomInset
            self.height = height
            self.cellSpacing = cellSpacing
            self.paddingWidth = leftInset + rightInset + CGFloat(cellCount - 1) * cellSpacing
        }
    }
}
