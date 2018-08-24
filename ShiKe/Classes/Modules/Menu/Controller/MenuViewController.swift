//
//  MenuViewController.swift
//  ShiKe
//
//  Created by 沈永聪 on 2018/6/7.
//  Copyright © 2018年 沈永聪. All rights reserved.
//

import UIKit

class MenuViewController: BaseViewController {
    //MARK:- Members
    let cell_reuseIdentifier = "ProductCell"
    
    var menuBar: MenuBar!
    var collectionView: UICollectionView!
    
    var productList: Array<ProductViewModel>?
    var filteredList: Array<ProductViewModel>?

    //MARK:- Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setupNavItems()
        setupMenuBar()
        setupCollectionView()
        
        debugData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK:- Setup
    func setupNavItems() {
        setupNavItems(title: shike_localized("shike_nav_title_menu"))
    }
    
    func setupMenuBar() {
        menuBar = MenuBar(frame: CGRect(x: 0, y: 0, width: shike_screen_width, height: 44))
        menuBar.menus = ["全部", "咖啡", "冰沙", "果汁", "飘雪"]
        menuBar.switchBlock = { (type: Int) -> Void in
            self.filteredList = type == 0 ? self.productList : self.productList?.filter({ (viewModel) -> Bool in
                Int(viewModel.typeStr!)! == type
            })
            self.collectionView.reloadData()
        }
        self.view.addSubview(menuBar)
    }
    
    func setupCollectionView() {
        let itemWidth: CGFloat = (shike_screen_width - 20 * 2 - 15) / 2.0
        let itemHeight: CGFloat = itemWidth + 20 * 2 + 15 + 8
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
        collectionView.register(ProductCell.self, forCellWithReuseIdentifier: cell_reuseIdentifier)
        
        collectionView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(self.view)
            make.top.equalTo(menuBar.snp.bottom)
        }
    }
    
    //MARK:- Debug data
    func debugData() {
        let jsonData = try! Data(contentsOf: Bundle.main.url(forResource: "menu", withExtension: "json")!)
        let list = try? JSONDecoder().decode([Product].self, from: jsonData)
        if let list = list {
            productList = Array<ProductViewModel>()
            for product in list {
                productList?.append(ProductViewModel(product))
            }
        }
        filteredList = productList
    }
}

extension MenuViewController: UICollectionViewDataSource {
    //MARK:- UICollectionViewDataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cell_reuseIdentifier, for: indexPath) as! ProductCell
        cell.viewModel = filteredList?[indexPath.item]
        cell.addBlock = { [weak self](viewModel) in
            let productVC = AddToCartViewController()
            productVC.viewModel = AddToCartViewModel(viewModel.product)
            productVC.hidesBottomBarWhenPushed = true
            self?.navigationController?.pushViewController(productVC, animated: true)
        }
        
        return cell
    }
}

extension MenuViewController: UICollectionViewDelegate {
    //MARK:- UICollectionViewDelegate
}
