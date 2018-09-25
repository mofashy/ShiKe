//
//  BannerLayout.swift
//  ShiKe
//
//  Created by 沈永聪 on 2018/6/8.
//  Copyright © 2018年 沈永聪. All rights reserved.
//
//  Thanks: https://github.com/KelvinJin/AnimatedCollectionViewLayout.git

import UIKit

class BannerLayoutAttributes: UICollectionViewLayoutAttributes {
    public var middleOffset: CGFloat = 0
}


class BannerLayout: UICollectionViewFlowLayout {
    
    public var animator: BannerLayoutAnimateProtocol?
    
    override class var layoutAttributesClass: AnyClass { return BannerLayoutAttributes.self }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let attributes = super.layoutAttributesForElements(in: rect) else { return nil }
        return attributes.compactMap{ $0.copy() as? BannerLayoutAttributes }.map{ self.transformAttributes($0) }
    }
    
    func transformAttributes(_ attributes: BannerLayoutAttributes) -> UICollectionViewLayoutAttributes {
        guard let collectionView = self.collectionView else { return attributes }
        
        let distance = collectionView.frame.width
        let itemOffset = attributes.center.x - collectionView.contentOffset.x
        
        attributes.middleOffset = itemOffset / distance - 0.5
        
        animator?.animate(collectionView: collectionView, attributes: attributes)
        
        return attributes
    }
}


protocol BannerLayoutAnimateProtocol {
    func animate(collectionView: UICollectionView, attributes: BannerLayoutAttributes)
}


class BannerLayoutAnimator: BannerLayoutAnimateProtocol {
    
    public var minAlpha: CGFloat
    public var itemSpacing: CGFloat
    public var scaleRate: CGFloat
    
    public init(minAlpha: CGFloat = 0.5, itemSpacing: CGFloat = 0.3, scaleRate: CGFloat = 0.8) {
        self.minAlpha = minAlpha
        self.itemSpacing = itemSpacing
        self.scaleRate = scaleRate
    }
    
    public func animate(collectionView: UICollectionView, attributes: BannerLayoutAttributes) {
        let position = attributes.middleOffset
        let scaleFactor = scaleRate - 0.1 * abs(position)
        let scaleTransform = CGAffineTransform(scaleX: scaleFactor, y: scaleFactor)
        
        let translationTransform: CGAffineTransform
        
        let width = collectionView.frame.width
        let translationX = -(width * itemSpacing * position)
        translationTransform = CGAffineTransform(translationX: translationX, y: 0)
        
        attributes.alpha = 1.0 - abs(position) + minAlpha
        attributes.transform = translationTransform.concatenating(scaleTransform)
    }
}
