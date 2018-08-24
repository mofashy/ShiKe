//
//  CartViewController.swift
//  ShiKe
//
//  Created by 沈永聪 on 2018/6/7.
//  Copyright © 2018年 沈永聪. All rights reserved.
//

import UIKit

class CartViewController: BaseViewController {
    //MARK:- Members
    let cell_reuseIdentifier = "CartProductCell"
    
    var collectionView: UICollectionView!
    lazy var totalView = CartTotalView(frame: .zero)
    
    var viewModel: CartViewModel!
    
    //MARK:- Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(self, selector: #selector(reloadProducts(_:)), name: NSNotification.Name(rawValue: ShiKeAddedProductsToCartNotification), object: nil)
        
        setupNavItems()
        setupTotalView()
        setupCollectionView()
        
        reloadProducts()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func reloadProducts(_ noti: Notification) {
        reloadProducts()
    }
    
    func reloadProducts() {
        viewModel = CartViewModel(debugData())
        viewModel.delegate = self
        totalView.viewModel = viewModel
        collectionView.reloadData()
    }
    
    //MARK:- Setup
    func setupNavItems() {
        setupNavItems(title: shike_localized("shike_nav_title_cart"))
    }
    
    func setupTotalView() {
        totalView.settleBlock = { [weak self]() in
            let confirmVC = ConfirmViewController()
            confirmVC.hidesBottomBarWhenPushed = true
            confirmVC.viewModel = PaidViewModel(self?.viewModel.productList)
            self?.navigationController?.pushViewController(confirmVC, animated: true)
        }
        self.view.addSubview(totalView)
        
        totalView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(self.view)
            make.height.equalTo(64)
        }
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
        collectionView.alwaysBounceVertical = true
        collectionView.backgroundColor = UIColor.white
        self.view.addSubview(collectionView)
        collectionView.register(CartProductCell.self, forCellWithReuseIdentifier: cell_reuseIdentifier)
        
        collectionView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(self.view)
            make.bottom.equalTo(totalView.snp.top)
        }
    }
    
    //MARK:- Debug data
    func debugData() -> [CartProductViewModel]? {
//        let jsonData = try! Data(contentsOf: Bundle.main.url(forResource: "cart", withExtension: "json")!)
//        let list = try? JSONDecoder().decode([CartProduct].self, from: jsonData)
        let list = TableManager.shared.queryAll(CartProduct.self) as? [CartProduct]
        if let list = list {
            var productList = Array<CartProductViewModel>()
            for product in list {
                productList.append(CartProductViewModel(product))
            }
            
            return productList
        }
        
        return nil
    }
    
    //MARK:- Notification
    @objc func reloadCart(_ noti: Notification) {
//        productList?.append(noti.object as! CartProductViewModel)
//        collectionView.reloadData()
    }
    
    //MARK:- Runtime
    func currentCell() -> CartProductCell? {
        let key: UnsafeRawPointer! = UnsafeRawPointer.init(bitPattern: "currentCell".hashValue)
        let cell = objc_getAssociatedObject(collectionView, key) as? CartProductCell
        
        return cell
    }

}

extension CartViewController: UICollectionViewDataSource {
    //MARK:- UICollectionViewDataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.productList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cell_reuseIdentifier, for: indexPath) as! CartProductCell
        cell.viewModel = viewModel.productList?[indexPath.item]
        cell.viewModel?.delegate = self
        cell.viewModel?.cell = cell
        
        return cell
    }
}

extension CartViewController: UICollectionViewDelegate {
    //MARK:- UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("\(indexPath.debugDescription)")
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        if let cell = currentCell() {
            cell.hideButtons(for: cell, animated: true)
        }
//        objc_setAssociatedObject(collectionView, key, nil, .OBJC_ASSOCIATION_ASSIGN)
    }
}

extension CartViewController: CartViewModelDelegate {
    //MARK:- CartViewModelDelegate
    func alertCartInfo() {
        
    }
    
    func reloadCart() {
        totalView.viewModel = viewModel
    }
    
    func reloadCells() {
        collectionView.reloadData()
    }
}

extension CartViewController: CartProductViewModelDelegate {
    //MARK:- CartProductViewModelDelegate
    func reloadCell(_ cell: CartProductCell?) {
        if let cell = cell {
            let index: Int! = viewModel.productList?.index(of: cell.viewModel!)
            UIView .performWithoutAnimation {
                collectionView.reloadItems(at: [IndexPath(item: index, section: 0)])
            }
        }
    }
    
    func alertInfo() {
        
    }
    
    func removeFromCart() {
        if let cell = currentCell() {
            let index: Int! = viewModel.productList?.index(of: cell.viewModel!)
            viewModel.removeProduct(at: index)
            collectionView.deleteItems(at: [IndexPath(item: index, section: 0)])
        }
    }
    
}
