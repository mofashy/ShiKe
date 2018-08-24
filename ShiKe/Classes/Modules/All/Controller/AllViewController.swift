//
//  AllViewController.swift
//  ShiKe
//
//  Created by 沈永聪 on 2018/6/7.
//  Copyright © 2018年 沈永聪. All rights reserved.
//

import UIKit

class AllViewController: BaseViewController {
    //MARK:- Const
    let header_reuseIdentifier = "CategoryHeader"
    let cell_reuseIdentifier = "CategoryCell"
    
    //MARK:- Members
    private var bannerView: BannerView!
    private var tableView: UITableView!
    
    private var categoryList: Array<CategoryViewModel>?
    
    //MARK:- Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        setupNavItems()
        setupTableView()
        setupHeaderView()
        
        debugData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:- Setup
    func setupNavItems() {
        setupNavItems(title: shike_localized("shike_nav_title_all"))
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "search"), style: .plain, target: self, action: #selector(searchAction(_:)))
    }
    
    func setupHeaderView() {
        bannerView = BannerView(frame: CGRect(x: 0, y: 0, width: shike_screen_width, height: (shike_screen_width - 40) * 9.0 / 16.0 + 40))
        tableView.tableHeaderView = bannerView
    }
    
    func setupTableView() {
        tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        self.view.addSubview(tableView)
        tableView.register(CategoryCell.self, forCellReuseIdentifier: cell_reuseIdentifier)
        tableView.register(CategoryHeader.self, forHeaderFooterViewReuseIdentifier: header_reuseIdentifier)
        
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
    }
    
    //MARK:- Debug data
    func debugData() {
        let jsonData = try! Data(contentsOf: Bundle.main.url(forResource: "all", withExtension: "json")!)
        let list = try? JSONDecoder().decode([Category].self, from: jsonData)
        if let list = list {
            categoryList = Array<CategoryViewModel>()
            for category in list {
                categoryList?.append(CategoryViewModel(category))
            }
        }
        
        bannerView.bannerList = [
            "",
            "",
            ""
        ]
    }
    
    //MARK:- Action
    @objc func searchAction(_ item: UIBarButtonItem) {
        //TODO: 实现搜索跳转
    }
}

extension AllViewController: UITableViewDataSource {
    //MARK:- UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return categoryList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cell_reuseIdentifier, for: indexPath) as! CategoryCell
        cell.viewModel = categoryList?[indexPath.section]
        cell.addBlock = { [weak self](viewModel) in
            let productVC = AddToCartViewController()
            productVC.viewModel = AddToCartViewModel(viewModel.product)
            productVC.hidesBottomBarWhenPushed = true
            self?.navigationController?.pushViewController(productVC, animated: true)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: header_reuseIdentifier) as! CategoryHeader
        header.viewModel = categoryList?[section]
        
        return header
    }
}

extension AllViewController: UITableViewDelegate {
    //MARK:- UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200.0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 55.0
    }
}
