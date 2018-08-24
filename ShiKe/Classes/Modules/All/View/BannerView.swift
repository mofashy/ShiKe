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
        let flowLayout = BannerLayout()
        collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: flowLayout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = UIColor.white
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
