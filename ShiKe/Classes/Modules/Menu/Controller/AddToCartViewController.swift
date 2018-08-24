//
//  AddToCartViewController.swift
//  ShiKe
//
//  Created by 沈永聪 on 2018/6/9.
//  Copyright © 2018年 沈永聪. All rights reserved.
//

import UIKit

class AddToCartViewController: BaseViewController {
    //MARK:- Members
    lazy var container = UIView()
    lazy var detailView = DetailsView(frame: .zero)
    lazy var capacityView = OptionalView(frame: .zero)
    lazy var temperatureView = OptionalView(frame: .zero)
    lazy var sugarinessView = OptionalView(frame: .zero)
    lazy var footer = AddToCartFooter(frame: .zero)
    
    lazy var optionalList = Array<[String: Any]>()
    
    var viewModel: AddToCartViewModel!

    //MARK:- Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.title = shike_localized("shike_nav_title_add")
        self.view.backgroundColor = shike_color_lightGray
        
        viewModel.delegate = self
        
        loadOptionals()
        
        setupFooter()
        setupContainer()
        setupDetailView()
        setupOptionalViews()
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
    func setupFooter() {
        self.view.addSubview(footer)
        footer.increaseBlock = { [weak self] in
            self?.viewModel.quantityDidIncrease()
        }
        footer.decreaseBlock = { [weak self] in
            self?.viewModel.quantityDidDecrease()
        }
        footer.settleBlock = { [weak self] in
            self?.viewModel.addToCart()
        }
        
        let tabBarHeight = self.tabBarController!.tabBar.frame.size.height
        
        let whiteFooter = UIView()
        whiteFooter.backgroundColor = UIColor.white
        self.view.addSubview(whiteFooter)
        
        whiteFooter.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(self.view)
            make.height.equalTo(tabBarHeight)
        }
        
        footer.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.view)
            make.bottom.equalTo(whiteFooter.snp.top)
            make.height.equalTo(64)
        }
    }
    
    func setupContainer() {
        container.backgroundColor = UIColor.white
        self.view.addSubview(container)
        
        let maskLayer = CAShapeLayer()
        maskLayer.path = UIBezierPath(roundedRect: self.view.bounds, byRoundingCorners: UIRectCorner(rawValue: UIRectCorner.topLeft.rawValue | UIRectCorner.topRight.rawValue), cornerRadii: CGSize(width: 15, height: 15)).cgPath
        container.layer.mask = maskLayer
        container.layer.masksToBounds = true
        
        detailView.viewModel = viewModel
        let height = 60.0 + CGFloat(50 * optionalList.count) + detailView.totalHeight()
        
        container.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.view)
            make.bottom.equalTo(footer.snp.top)
            make.height.equalTo(height)
        }
    }
    
    func setupDetailView() {
        container.addSubview(detailView)
        
        detailView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(container)
        }
    }
    
    func setupOptionalViews() {
        capacityView.dict = optionalList[0]
        capacityView.choiceBlock = { [weak self] (index) in
            self?.viewModel.capacityDidChange(capacity: [.tall, .grande, .venti][index])
        }
        temperatureView.dict = optionalList[1]
        temperatureView.choiceBlock = { [weak self] (index) in
            self?.viewModel.temperatureDidChange(temperature: [.less, .free, .hot][index])
        }
        sugarinessView.dict = optionalList[2]
        sugarinessView.choiceBlock = { [weak self] (index) in
            self?.viewModel.sugarinessDidChange(sugariness: [.less, .semi, .free][index])
        }
        
        container.addSubview(capacityView)
        container.addSubview(temperatureView)
        container.addSubview(sugarinessView)
        
        capacityView.snp.makeConstraints { (make) in
            make.left.right.equalTo(container)
            make.top.equalTo(detailView.snp.bottom)
            make.height.equalTo(50)
        }
        
        temperatureView.snp.makeConstraints { (make) in
            make.left.right.equalTo(container)
            make.top.equalTo(capacityView.snp.bottom)
            make.height.equalTo(50)
        }
        
        sugarinessView.snp.makeConstraints { (make) in
            make.left.right.equalTo(container)
            make.top.equalTo(temperatureView.snp.bottom)
            make.height.equalTo(50)
        }
    }
    
    //MARK:- Load local data
    func loadOptionals() {
        optionalList = NSArray(contentsOfFile: Bundle.main.path(forResource: "optionals", ofType: "plist")!) as! Array<[String: Any]>
    }
}

extension AddToCartViewController: AddToCartViewModelDelegate {
    //MARK:- ProductViewModelDelegate
    func reloadViews() {
        footer.quantity = viewModel.quantity
    }
    
    func alertInfo() {
        
    }
    
    func reloadCart() {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: ShiKeAddedProductsToCartNotification), object: nil)
        self.navigationController?.popViewController(animated: true)
    }
    
}
