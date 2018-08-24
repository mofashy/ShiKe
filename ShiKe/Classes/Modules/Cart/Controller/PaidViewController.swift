//
//  PaidViewController.swift
//  ShiKe
//
//  Created by 沈永聪 on 2018/6/13.
//  Copyright © 2018年 沈永聪. All rights reserved.
//

import UIKit

class PaidViewController: BaseViewController {
    //MARK:- Members
    let product_reuseIdentifier = "PaidProductCell"
    let total_reuseIdentifier = "PaidTotalCell"
    private lazy var tableView = UITableView()
    private lazy var header = PaidHeader(frame: CGRect(x: 0, y: 0, width: shike_screen_width, height: 50))
    
    var viewModel: PaidViewModel!
    
    //MARK:- Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.title = shike_localized("shike_nav_title_paid")
        self.view.backgroundColor = shike_color_lightGray
        
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.navigationBar.barTintColor = shike_color_lightGray
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.navigationBar.barTintColor = UIColor.white
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:- Setup
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.isScrollEnabled = false
        tableView.separatorStyle = .none
        tableView.contentInset = UIEdgeInsets(top: (shike_screen_height - UIApplication.shared.statusBarFrame.size.height) * 0.3, left: 0, bottom: 0, right: 0)
        tableView.register(PaidProductCell.self, forCellReuseIdentifier: product_reuseIdentifier)
        tableView.register(PaidTotalCell.self, forCellReuseIdentifier: total_reuseIdentifier)
        self.view.addSubview(tableView)
        
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
        
        let maskLayer = CAShapeLayer()
        maskLayer.path = UIBezierPath(roundedRect: self.view.bounds, byRoundingCorners: UIRectCorner(rawValue: UIRectCorner.topLeft.rawValue | UIRectCorner.topRight.rawValue), cornerRadii: CGSize(width: 15, height: 15)).cgPath
        tableView.layer.mask = maskLayer
        tableView.layer.masksToBounds = true
        
        tableView.tableHeaderView = header
    }

}

extension PaidViewController: UITableViewDataSource {
    //MARK:- UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let productList = viewModel.productList {
            return productList.count + 1
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let productList = viewModel.productList else {
            let cell = tableView.dequeueReusableCell(withIdentifier: total_reuseIdentifier, for: indexPath) as! PaidTotalCell
            cell.viewModel = viewModel
            
            return cell
        }
        
        if indexPath.row < productList.count {
            let cell = tableView.dequeueReusableCell(withIdentifier: product_reuseIdentifier, for: indexPath) as! PaidProductCell
            cell.viewModel = viewModel.productList?[indexPath.row]
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: total_reuseIdentifier, for: indexPath) as! PaidTotalCell
            cell.viewModel = viewModel
            
            return cell
        }
    }
    
}

extension PaidViewController: UITableViewDelegate {
    //MARK:- UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let productList = viewModel.productList else {
            return 50
        }
        
        if indexPath.row < productList.count {
            return 70
        } else {
            return 50
        }
    }
}
