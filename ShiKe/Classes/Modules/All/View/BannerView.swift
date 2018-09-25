//
//  BannerView.swift
//  ShiKe
//
//  Created by 沈永聪 on 2018/6/8.
//  Copyright © 2018年 沈永聪. All rights reserved.
//

import UIKit

class BannerView: UIView {
    //MARK:- Members
    var bannerList: Array<Any>? {
        didSet {
            pageControl.numberOfPages = bannerList!.count
        }
    }
    
    private let reuseIdentifier = "BannerCell"
    
    private var collectionView: UICollectionView!
    private lazy var pageControl = UIPageControl()
    fileprivate var animator: BannerLayoutAnimateProtocol?
    
    //MARK:- Life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.white
        
        setupSubviews()
        configLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- Setup
    func setupSubviews() {
        animator = BannerLayoutAnimator()
        
        let flowLayout = BannerLayout()
        flowLayout.animator = animator
        flowLayout.scrollDirection = .horizontal
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: bounds.width, height: bounds.width * 9 / 16), collectionViewLayout: flowLayout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = UIColor.white
        collectionView.isPagingEnabled = true
        collectionView.register(BannerCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        self.addSubview(collectionView)
        
        pageControl.pageIndicatorTintColor = shike_color_whitePink
        pageControl.currentPageIndicatorTintColor = shike_color_darkPink
        self.addSubview(pageControl)
    }
    
    //MARK:- Layout
    func configLayout() {
        pageControl.snp.makeConstraints { (make) in
            make.bottom.centerX.equalTo(self)
            make.height.equalTo(20)
        }
    }
}

extension BannerView: UICollectionViewDataSource {
    //MARK:- UICollectionViewDataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bannerList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! BannerCell
        
        return cell
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        // 40.0 -- 左右边距，15.0 -- cell间距，即minimumInteritemSpacing
        pageControl.currentPage = Int(scrollView.contentOffset.x / (scrollView.bounds.size.width - 40.0 * 2 + 15.0))
    }
}

extension BannerView: UICollectionViewDelegate {
    
}

//MARK:- UICollectionViewDelegateFlowLayout
extension BannerView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }
}
