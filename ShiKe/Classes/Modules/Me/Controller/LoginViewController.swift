//
//  LoginViewController.swift
//  ShiKe
//
//  Created by 沈永聪 on 2018/6/11.
//  Copyright © 2018年 沈永聪. All rights reserved.
//

import UIKit

class LoginViewController: BaseViewController {
    //MARK:- Members
    lazy var container = UIView()
    lazy var usernameView = LoginInputView(frame: .zero)
    lazy var passwordView = LoginInputView(frame: .zero)
    lazy var verifyView = LoginInputView(frame: .zero)
    lazy var loginView = LoginButtonView(frame: .zero)
    lazy var registerView = LoginButtonView(frame: .zero)
    lazy var thirdPartyView = LoginThirdView(frame: .zero)
    
    lazy var header = LoginMenuBar(frame: CGRect(x: 0, y: 0, width: shike_screen_width, height: 90))
    lazy var footer = LoginFooter(frame: CGRect(x: 0, y: 0, width: shike_screen_width, height: 50))
    
    var type: ButtonType = .login
    var viewModel: LoginViewModel!
    
    
    //MARK:- Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.view.backgroundColor = shike_color_lightGray
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
        viewModel = LoginViewModel()
        viewModel.delegate = self
        
        setupNavItems()
        setupContainer()
        setupInputViews()
        setupButtonViews()
        setupThirdPartyView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:- Setup
    func setupNavItems() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "close"), style: .plain, target: self, action: #selector(closeAction(_:)))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: shike_localized("shike_nav_item_forget"), style: .plain, target: self, action: #selector(forgetAction(_:)))
    }
    
    func setupContainer() {
        container.backgroundColor = UIColor.white
        self.view.addSubview(container)
        
        let maskLayer = CAShapeLayer()
        maskLayer.path = UIBezierPath(roundedRect: self.view.bounds, byRoundingCorners: UIRectCorner(rawValue: UIRectCorner.topLeft.rawValue | UIRectCorner.topRight.rawValue), cornerRadii: CGSize(width: 15, height: 15)).cgPath
        container.layer.mask = maskLayer
        container.layer.masksToBounds = true
        
        container.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(self.view)
            make.height.equalTo(410)
        }
        
        container.addSubview(header)
        header.switchBlock = { [weak self](type: ButtonType) in
            self?.type = type
            self?.switchUI()
        }
        
        container.addSubview(footer)
        footer.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(container)
            make.height.equalTo(50)
        }
    }
    
    func setupInputViews() {
        usernameView.type = .username
        usernameView.delegate = self
        passwordView.type = .password
        passwordView.delegate = self
        verifyView.type = .verify
        verifyView.delegate = self
        verifyView.isHidden = true
        
        container.addSubview(usernameView)
        container.addSubview(passwordView)
        container.addSubview(verifyView)
        
        usernameView.snp.makeConstraints { (make) in
            make.left.right.equalTo(container)
            make.top.equalTo(header.snp.bottom)
            make.height.equalTo(60)
        }
        
        passwordView.snp.makeConstraints { (make) in
            make.left.right.equalTo(container)
            make.top.equalTo(usernameView.snp.bottom)
            make.height.equalTo(60)
        }
        
        verifyView.snp.makeConstraints { (make) in
            make.left.right.equalTo(container)
            make.top.equalTo(passwordView.snp.bottom)
            make.height.equalTo(60)
        }
    }
    
    func setupButtonViews() {
        loginView.type = .login
        loginView.block = { [weak self] in
            self?.viewModel.login()
        }
        registerView.type = .register
        registerView.block = { [weak self] in
            self?.viewModel.register()
        }
        registerView.isHidden = true
        
        container.addSubview(loginView)
        container.addSubview(registerView)
        
        loginView.snp.makeConstraints { (make) in
            make.left.right.equalTo(container)
            make.top.equalTo(passwordView.snp.bottom)
            make.height.equalTo(60)
        }
        
        registerView.snp.makeConstraints { (make) in
            make.left.right.equalTo(container)
            make.top.equalTo(verifyView.snp.bottom)
            make.height.equalTo(60)
        }
    }
    
    func setupThirdPartyView() {
        container.addSubview(thirdPartyView)
        
        thirdPartyView.snp.makeConstraints { (make) in
            make.left.right.equalTo(container)
            make.top.equalTo(loginView.snp.bottom)
            make.height.equalTo(90)
        }
    }
    
    //MARK:- Switch state
    func switchUI() {
        loginView.isHidden = type == .register
        thirdPartyView.isHidden = type == .register
        
        verifyView.isHidden = type == .login
        registerView.isHidden = type == .login
    }
    
    //MARK:- Action
    @objc func closeAction(_ item: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func forgetAction(_ item: UIBarButtonItem) {
        
    }
}

extension LoginViewController: LoginInputViewDelegate {
    //MARK:- LoginInputViewDelegate
    func textChanged(text: String?, type: TextFieldType?) {
        if let type = type {
            switch type {
            case .username:
                viewModel.usernameDidChange(text: text)
            case .password:
                viewModel.passwordDidChange(text: text)
            case .verify:
                viewModel.verifyDidChange(text: text)
            }
        }
    }
}

extension LoginViewController: LoginViewModelDelegate {
    //MARK:- LoginViewModelDelegate
    func reloadViews() {
        loginView.enableButton(isEnabled: viewModel.loginButtonEnable)
        registerView.enableButton(isEnabled: viewModel.registerButtonEnable)
    }
    
    func alertInfo() {
        
    }
    
    func reloadHome() {
        //FIXME: 通知其他界面刷新
        self.dismiss(animated: true, completion: nil)
    }
    
}
