//
//  CouponViewController.swift
//  ShiKe
//
//  Created by 沈永聪 on 2018/6/10.
//  Copyright © 2018年 沈永聪. All rights reserved.
//

import UIKit

class CouponViewController: BaseViewController {
    //MARK:- Members
    let cell_reuseIdentifier = "OrdersCell"
    
    var collectionView: UICollectionView!
    var menuBar: MenuBar!
    
    var orderList: [CouponViewModel]?
    var filteredList: [CouponViewModel]?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.title = shike_localized("shike_nav_title_coupon")
        
        setupMenuBar()
        setupCollectionView()
        
        debugData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:- Setup
    func setupMenuBar() {
        menuBar = MenuBar(frame: CGRect(x: 0, y: 0, width: shike_screen_width, height: 44))
        menuBar.menus = ["全部", "未使用", "已使用", "已过期"]
        menuBar.switchBlock = { [weak self](state: Int) -> Void in
            self?.filteredList = state == 0 ? self?.orderList : self?.orderList?.filter({ (viewModel: CouponViewModel) -> Bool in
                viewModel.state?.rawValue == state
            })
            
            self?.collectionView.reloadData()
        }
        self.view.addSubview(menuBar)
    }
    
    func setupCollectionView() {
        let itemWidth: CGFloat = shike_screen_width - 20 * 2
        let itemHeight: CGFloat = 80
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 15
        flowLayout.minimumInteritemSpacing = 15
        flowLayout.sectionInset = UIEdgeInsetsMake(10, 20, 0, 20)
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = UIColor.white
        self.view.addSubview(collectionView)
        collectionView.register(CouponCell.self, forCellWithReuseIdentifier: cell_reuseIdentifier)
        
        collectionView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(self.view)
            make.top.equalTo(menuBar.snp.bottom)
        }
    }
    
    //MARK:- Debug data
    func debugData() {
        let jsonData = try! Data(contentsOf: Bundle.main.url(forResource: "coupon", withExtension: "json")!)
        let list = try? JSONDecoder().decode([Coupon].self, from: jsonData)
        if let list = list {
            orderList = [CouponViewModel]()
            for coupon in list {
                orderList?.append(CouponViewModel(coupon))
            }
        }
        
        filteredList = orderList
    }

}

extension CouponViewController: UICollectionViewDataSource {
    //MARK:- UICollectionViewDataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cell_reuseIdentifier, for: indexPath) as! CouponCell
        cell.viewModel = filteredList?[indexPath.item]
        
        return cell
    }
}

extension CouponViewController: UICollectionViewDelegate {
    //MARK:- UICollectionViewDelegate
}
