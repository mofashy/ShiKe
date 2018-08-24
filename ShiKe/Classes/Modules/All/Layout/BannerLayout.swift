//
//  BannerLayout.swift
//  ShiKe
//
//  Created by 沈永聪 on 2018/6/8.
//  Copyright © 2018年 沈永聪. All rights reserved.
//

import UIKit

class BannerLayout: UICollectionViewFlowLayout {
    override init() {
        super.init()
        
        self.scrollDirection = .horizontal
        self.minimumLineSpacing = 15
        self.minimumInteritemSpacing = 15
        self.sectionInset = UIEdgeInsets(top: 0, left: 40.0, bottom: 0, right: 40.0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepare() {
        super.prepare()
        
        let itemWidth = self.collectionView!.bounds.size.width - 40.0 * 2
        self.itemSize = CGSize(width: itemWidth, height: itemWidth * 9.0 / 16.0)
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let oldAttributes = super.layoutAttributesForElements(in: rect)
        var newAttributes = [UICollectionViewLayoutAttributes]()
        for attribute in oldAttributes! {
            newAttributes.append(attribute.copy() as! UICollectionViewLayoutAttributes)
        }
        
        let visibleRect: CGRect = CGRect(origin: self.collectionView!.contentOffset, size: self.collectionView!.bounds.size)
        
        for attribute in newAttributes {
            if attribute.frame.intersects(rect) {
                let distance = fabs(visibleRect.midX - attribute.center.x)
                if distance < self.collectionView!.bounds.size.width / 2.0 + self.itemSize.width {
                    let scale = 1 + 0.1 * (1 - distance / 200)
                    attribute.transform = CGAffineTransform.init(scaleX: scale, y: scale)
                }
            }
        }

        return newAttributes
    }
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        var offsetAdjustment: CGFloat = CGFloat(MAXFLOAT)
        let horizontalCenter = proposedContentOffset.x + self.collectionView!.bounds.width / 2.0
        let targetRect = CGRect(x: proposedContentOffset.x, y: 0.0, width: self.collectionView!.bounds.size.width, height: self.collectionView!.bounds.size.height)
        let attributes = super.layoutAttributesForElements(in: targetRect)
        
        for attribute in attributes! {
            let itemHorizontalCenter = attribute.center.x
            if fabs(itemHorizontalCenter - horizontalCenter) < fabs(offsetAdjustment) {
                offsetAdjustment = CGFloat(itemHorizontalCenter - horizontalCenter)
            }
        }
        
        return CGPoint(x: proposedContentOffset.x + offsetAdjustment, y: proposedContentOffset.y)
    }
}
