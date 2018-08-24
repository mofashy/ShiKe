//
//  MeViewController.swift
//  ShiKe
//
//  Created by 沈永聪 on 2018/6/7.
//  Copyright © 2018年 沈永聪. All rights reserved.
//

import UIKit

class MeViewController: BaseViewController {
    //MARK:- Members
    let cell_reuseIdentifier = "ProfileCell"
    let header_reuseIdentifier = ""
    lazy var profileList = [[[String: Any]]]()
    
    lazy var tableView = UITableView()
    lazy var profileHeader = ProfileHeader(frame: CGRect(x: 0, y: 0, width: shike_screen_width, height: 80))
    lazy var userView = UserView(frame: CGRect(x: 0, y: 0, width: shike_screen_width, height: 90))

    //MARK:- Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = shike_color_lightGray
        
        setupNavItems()
        setupUserView()
        setupTableView()
        loadProfiles()
        
        debugData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.navigationBar.barTintColor = shike_color_lightGray
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:- Setup
    func setupNavItems() {
        setupNavItems(title: shike_localized("shike_nav_title_me"))
    }
    
    func setupUserView() {
        self.view.addSubview(userView)
        
        userView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(self.view)
            make.height.equalTo(userView.bounds.size.height)
        }
    }
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 50
        tableView.separatorStyle = .none
        tableView.contentInset = UIEdgeInsets(top: 90, left: 0, bottom: 0, right: 0)
        self.view.addSubview(tableView)
        tableView.register(ProfileCell.self, forCellReuseIdentifier: cell_reuseIdentifier)
        
        tableView.tableHeaderView = profileHeader
        profileHeader.naviBlock = { (index: Int) -> Void in
            switch index {
            case 0:
                let loginVC = BaseNavigationController(rootViewController: LoginViewController())
                self .present(loginVC, animated: true, completion: nil)
            case 1:
                let couponVC = CouponViewController()
                couponVC.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(couponVC, animated: true)
            case 2:
                let ordersVC = OrdersViewController()
                ordersVC.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(ordersVC, animated: true)
            default:
            assert(0 == 0)
            }
        }
        
        let maskLayer = CAShapeLayer()
        maskLayer.path = UIBezierPath(roundedRect: self.view.bounds, byRoundingCorners: UIRectCorner(rawValue: UIRectCorner.topLeft.rawValue | UIRectCorner.topRight.rawValue), cornerRadii: CGSize(width: 15, height: 15)).cgPath
        tableView.layer.mask = maskLayer
        tableView.layer.masksToBounds = true
        
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
    }
    
    //MARK:- Load local data
    func loadProfiles() {
        profileList = NSArray(contentsOfFile: Bundle.main.path(forResource: "profiles", ofType: "plist")!) as! [[[String: Any]]]
        
        profileHeader.profileList = profileList.first
    }
    
    //MARK:- Debug data
    func debugData() {
        let jsonData = try! Data(contentsOf: Bundle.main.url(forResource: "user", withExtension: "json")!)
        let user = try? JSONDecoder().decode(User.self, from: jsonData)
        if let user = user {
            userView.viewModel = UserViewModel(user)
        }
    }
}

extension MeViewController: UITableViewDataSource {
    //MARK:- UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return profileList.last?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cell_reuseIdentifier, for: indexPath) as! ProfileCell
        cell.accessoryType = .disclosureIndicator
        cell.profile = profileList.last?[indexPath.row]
        
        return cell
    }
}

extension MeViewController: UITableViewDelegate {
    //MARK:- UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
