//
//  ConfirmViewController.swift
//  ShiKe
//
//  Created by 沈永聪 on 2018/6/13.
//  Copyright © 2018年 沈永聪. All rights reserved.
//

import UIKit

class ConfirmViewController: BaseViewController {
    //MARK:- Members
    let address_reuseIdentifier = "OrderAddressCell"
    let product_reuseIdentifier = "OrderProductCell"
    let append_reuseIdentifier = "OrderAppendCell"
    let header_reuseIdentifier = "OrderSectionHeader"
    
    var footer: OrderFooter!
    var collectionView: UICollectionView!
    
    var viewModel: PaidViewModel!
    
    //MARK:- Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.navigationItem.title = shike_localized("shike_nav_title_confirm")
        
        setupFooter()
        setupCollectionView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:- Setup
    func setupFooter() {
        footer = OrderFooter(frame: .zero)
        footer.viewModel = viewModel
        footer.payBlock = { [weak self] () in
            if let productList = self?.viewModel.productList {
                for vm in productList {
                    //FIXME: 将购物车商品状态改成其他
                    let product = vm.product
                    product?.state = .finish
                    
                    TableManager.shared.updateTable(product)
                }
            }
            
            NotificationCenter.default.post(name: Notification.Name(rawValue: ShiKeAddedProductsToCartNotification), object: nil)
            
            let paidVC = PaidViewController()
            paidVC.viewModel = self?.viewModel
            self?.navigationController?.pushViewController(paidVC, animated: true)
        }
        self.view.addSubview(footer)
        
        footer.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(self.view)
            make.height.equalTo(64)
        }
    }
    
    func setupCollectionView() {
        let flowLayout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = shike_color_lightGray
        self.view.addSubview(collectionView)
        collectionView.register(OrderAddressCell.self, forCellWithReuseIdentifier: address_reuseIdentifier)
        collectionView.register(OrderProductCell.self, forCellWithReuseIdentifier: product_reuseIdentifier)
        collectionView.register(OrderAppendCell.self, forCellWithReuseIdentifier: append_reuseIdentifier)
        collectionView.register(OrderSecitonHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: header_reuseIdentifier)
        
        collectionView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(self.view)
            make.bottom.equalTo(footer.snp.top)
        }
    }
    
    func assignCell(_ cell: OrderAppendCell, title: String?, detail: String?, detailColor: UIColor?) {
        cell.titleLabel.text = title
        cell.detailsLabel.text = detail
        cell.detailsLabel.textColor = detailColor
    }
    
}

extension ConfirmViewController: UICollectionViewDataSource {
    //MARK:- UICollectionViewDataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            return viewModel.productList?.count ?? 0
        } else {
            return 4
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: address_reuseIdentifier, for: indexPath) as! OrderAddressCell
            //            cell.viewModel = productList?[indexPath.item]
            
            return cell
        } else if indexPath.section == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: product_reuseIdentifier, for: indexPath) as! OrderProductCell
            cell.viewModel = viewModel.productList?[indexPath.item]
            if indexPath.item == 0 {
                cell.maskTop()
            }
            if indexPath.item == viewModel.productList!.count - 1 {
                cell.maskBottom()
            }
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: append_reuseIdentifier, for: indexPath) as! OrderAppendCell
            cell.accessoryType = .none
            switch indexPath.item {
            case 0:
                assignCell(cell, title: shike_localized("shike_confirm_deliveryFee"), detail: "订单满50元免配送费", detailColor: shike_color_darkGray)
                cell.maskTop()
            case 1:
                assignCell(cell, title: shike_localized("shike_confirm_coupon"), detail: "满100减20", detailColor: shike_color_darkPink)
                cell.accessoryType = .indicator
            case 2:
                assignCell(cell, title: shike_localized("shike_confirm_payType"), detail: "微信支付", detailColor: shike_color_darkPink)
                cell.accessoryType = .indicator
            case 3:
                assignCell(cell, title: shike_localized("shike_confirm_actuallyPay"), detail: viewModel.actuallyPay, detailColor: shike_color_darkPink)
                cell.maskBottom()
            default:
                print("")
            }
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: header_reuseIdentifier, for: indexPath) as! OrderSecitonHeader
        header.titleLabel.text = shike_localized("shike_section_title_orderInfo")
        
        return header
    }
}

extension ConfirmViewController: UICollectionViewDelegate {
    //MARK:- UICollectionViewDelegate
}

extension ConfirmViewController: UICollectionViewDelegateFlowLayout {
    //MARK:- UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth: CGFloat = shike_screen_width - 20 * 2
        if indexPath.section == 0 {
            return CGSize(width: itemWidth, height: 95)
        } else if indexPath.section == 1 {
            return CGSize(width: itemWidth, height: 110)
        } else {
            return CGSize(width: itemWidth, height: 50)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if section == 0 {
            return UIEdgeInsets(top: 20, left: 20, bottom: 15, right: 20)
        } else if section == 1 {
            return UIEdgeInsets(top: 15, left: 20, bottom: 20, right: 20)
        } else {
            return UIEdgeInsets(top: 0, left: 20, bottom: 40, right: 20)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 1 {
            return CGSize(width: shike_screen_width, height: 20)
        } else {
            return .zero
        }
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        <#code#>
//    }
}
