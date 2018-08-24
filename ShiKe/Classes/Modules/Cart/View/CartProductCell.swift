//
//  CartProductCell.swift
//  ShiKe
//
//  Created by 沈永聪 on 2018/6/9.
//  Copyright © 2018年 沈永聪. All rights reserved.
//

import UIKit

class CartProductCell: UICollectionViewCell {
    //MARK:- Members
    private lazy var checkbox = UIButton()
    private lazy var imageView = UIImageView()
    private lazy var titleLabel = UILabel()
    private lazy var detailsLabel = UILabel()
    private lazy var priceLabel = UILabel()
    private lazy var minusButton = UIButton()
    private lazy var quantityLabel = UILabel()
    private lazy var plusButton = UIButton()
    private lazy var deleteButton = UIButton()
    private var pan: UIPanGestureRecognizer!
    private var tap: UITapGestureRecognizer!
    
    var viewModel: CartProductViewModel? {
        didSet {
            checkbox.isSelected = viewModel!.isCheck
            titleLabel.text = viewModel?.titleStr
            detailsLabel.text = viewModel?.detailStr
            priceLabel.text = viewModel?.priceStr
            quantityLabel.text = viewModel?.quantityStr
        }
    }
    
    //MARK:- Life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
        self.backgroundColor = UIColor.white
        self.contentView.backgroundColor = UIColor(hex: 0xFDF7F7)
        
        pan = UIPanGestureRecognizer(target: self, action: #selector(panCell(_:)))
        pan.delegate = self
        pan.delaysTouchesBegan = true
        
        tap = UITapGestureRecognizer(target: self, action: #selector(tapCell(_:)))
        
        self.addGestureRecognizer(pan)
        
        setupSubviews()
        configLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- Setup
    func setupSubviews() {
        checkbox.adjustsImageWhenHighlighted = false
        checkbox.setImage(UIImage(named: "uncheck"), for: .normal)
        checkbox.setImage(UIImage(named: "check"), for: .selected)
        checkbox.addTarget(self, action: #selector(checkAction(_:)), for: .touchUpInside)
        
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 3
        imageView.layer.masksToBounds = true
        #if DEBUG
        imageView.backgroundColor = shike_color_darkPink
        #endif
        
        titleLabel.font = shike_mediumFont(14)
        titleLabel.textColor = shike_color_black
        
        detailsLabel.font = shike_regularFont(10)
        detailsLabel.textColor = shike_color_darkGray
        
        priceLabel.font = shike_mediumFont(14)
        priceLabel.textColor = shike_color_darkPink
        
        minusButton.setTitleColor(shike_color_darkPink, for: .normal)
        minusButton.setImage(UIImage(named: "minus"), for: .normal)
        minusButton.addTarget(self, action: #selector(stepAction(_:)), for: .touchUpInside)
        
        quantityLabel.font = shike_regularFont(14)
        quantityLabel.textColor = shike_color_darkGray
        quantityLabel.textAlignment = .center
        
        plusButton.setTitleColor(shike_color_darkPink, for: .normal)
        plusButton.setImage(UIImage(named: "plus"), for: .normal)
        plusButton.addTarget(self, action: #selector(stepAction(_:)), for: .touchUpInside)
        
        deleteButton.backgroundColor = UIColor.red
        deleteButton.setTitle("Delete", for: .normal)
        deleteButton.setTitleColor(UIColor.white, for: .normal)
        deleteButton.addTarget(self, action: #selector(deleteAction(_:)), for: .touchUpInside)
        
        self.contentView.addSubview(checkbox)
        self.contentView.addSubview(imageView)
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(detailsLabel)
        self.contentView.addSubview(priceLabel)
        self.contentView.addSubview(minusButton)
        self.contentView.addSubview(quantityLabel)
        self.contentView.addSubview(plusButton)
        self.insertSubview(deleteButton, belowSubview: self.contentView)
    }
    
    //MARK:- Layout
    func configLayout() {
        checkbox.snp.makeConstraints { (make) in
            make.left.equalTo(self.contentView.snp.left).offset(15)
            make.centerY.equalTo(self.contentView.snp.centerY)
            make.height.width.equalTo(24)
        }
        
        imageView.snp.makeConstraints { (make) in
            make.left.equalTo(checkbox.snp.right).offset(15)
            make.top.equalTo(self.contentView.snp.top).offset(10)
            make.bottom.equalTo(self.contentView.snp.bottom).offset(-10)
            make.width.equalTo(imageView.snp.height)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(imageView.snp.right).offset(10)
            make.top.equalTo(imageView.snp.top)
            make.right.lessThanOrEqualTo(minusButton.snp.left).offset(-10)
        }
        
        detailsLabel.snp.makeConstraints { (make) in
            make.left.equalTo(titleLabel.snp.left)
            make.top.equalTo(titleLabel.snp.bottom).offset(2)
            make.right.lessThanOrEqualTo(minusButton.snp.left).offset(-10)
        }
        
        priceLabel.snp.makeConstraints { (make) in
            make.left.equalTo(titleLabel.snp.left)
            make.bottom.equalTo(imageView.snp.bottom).offset(2)
            make.right.lessThanOrEqualTo(minusButton.snp.left).offset(-10)
        }
        
        plusButton.snp.makeConstraints { (make) in
            make.right.equalTo(self.contentView.snp.right).offset(-15)
            make.centerY.equalTo(self.contentView.snp.centerY)
            make.height.width.equalTo(22)
        }
        
        quantityLabel.snp.makeConstraints { (make) in
            make.right.equalTo(plusButton.snp.left)
            make.left.equalTo(minusButton.snp.right)
            make.centerY.equalTo(self.contentView.snp.centerY)
            make.width.equalTo(25)
        }
        
        minusButton.snp.makeConstraints { (make) in
            make.right.equalTo(quantityLabel.snp.left)
            make.centerY.equalTo(self.contentView.snp.centerY)
            make.height.width.equalTo(22)
        }
        
        deleteButton.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.right)
            make.top.bottom.equalTo(self)
            make.width.equalTo(70)
        }
    }
    
    //MARK:- Action
    @objc func checkAction(_ button: UIButton) {
//        button.isSelected = !button.isSelected
        
        viewModel?.checkboxDidChecked(!button.isSelected)
//        button.isSelected = viewModel!.isCheck
    }
    
    @objc func stepAction(_ button: UIButton) {
        if button == minusButton {
            viewModel?.quantityDidDecrease()
        } else {
            viewModel?.quantityDidIncrease()
        }
//        quantityLabel.text = viewModel?.quantityStr
    }
    
    @objc func deleteAction(_ button: UIButton) {
        hideButtons(for: self, animated: true)
        
        viewModel?.removeFromCart()
    }
    
    @objc func tapCell(_ gesture: UITapGestureRecognizer) {
        hideButtons(for: self, animated: true)
    }
    
    private var start = CGPoint.zero
    private var origin = CGPoint.zero
    private var delOrigin = CGPoint.zero
    private var isLeft = false
    private var shouldRight = false
    private var distance: CGFloat = 0
    private let DelBtnWidth: CGFloat = 70
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        origin = self.contentView.center
        delOrigin = deleteButton.center
    }
    
    @objc func panCell(_ gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case .began:
            start = gesture.location(in: self)
            self.associateCell()
        case .changed:
            let offsetX = gesture.location(in: self).x - start.x
            isLeft = offsetX < 0
            
            if (isLeft && shouldRight) || (!isLeft && !shouldRight) {
                return
            }
            
            distance = isLeft ? max(-DelBtnWidth, offsetX * 0.6) : min(DelBtnWidth, offsetX * 0.6)
            self.contentView.center = CGPoint(x: origin.x + distance, y: origin.y)
            deleteButton.center = CGPoint(x: delOrigin.x + distance, y: delOrigin.y)
        case .ended:
            fallthrough
        case .cancelled:
            if (isLeft && shouldRight) || (!isLeft && !shouldRight) {
                return
            }
            
            if isLeft {
                isLeft = fabs(self.distance) > self.DelBtnWidth / 2
                UIView.animate(withDuration: 0.25, animations: {
                    self.contentView.center = CGPoint(x: self.origin.x + (self.isLeft ? -self.DelBtnWidth : 0), y: self.origin.y)
                    self.deleteButton.center = CGPoint(x: self.delOrigin.x + (self.isLeft ? -self.DelBtnWidth : 0), y: self.delOrigin.y)
                }) { (finished) in
                    self.origin = self.contentView.center
                    self.delOrigin = self.deleteButton.center
                    self.shouldRight = self.isLeft
                    self.addGestureRecognizer(self.tap)
                }
            } else {
                let isRight = fabs(self.distance) > self.DelBtnWidth / 2
                UIView.animate(withDuration: 0.25, animations: {
                    self.contentView.center = CGPoint(x: self.origin.x + (isRight ? self.DelBtnWidth : 0), y: self.origin.y)
                    self.deleteButton.center = CGPoint(x: self.delOrigin.x + (isRight ? self.DelBtnWidth : 0), y: self.delOrigin.y)
                }) { (finished) in
                    self.origin = self.contentView.center
                    self.delOrigin = self.deleteButton.center
                    self.shouldRight = !isRight
                    self.removeGestureRecognizer(self.tap)
                }
            }
        default:
            print("")
        }
    }
    
    func associateCell() {
        var view = self.superview
        while !(view is UICollectionView) {
            view = view?.superview
        }
        
        if let view = view {
            let key: UnsafeRawPointer! = UnsafeRawPointer.init(bitPattern: "currentCell".hashValue)
            let cell = objc_getAssociatedObject(view, key) as? CartProductCell
            
            if let cell = cell {
                if cell != self {
                    hideButtons(for: cell, animated: true)
                }
            }
            
            objc_setAssociatedObject(view, key, self, .OBJC_ASSOCIATION_ASSIGN)
        }
    }
    
    func hideButtons(for cell: CartProductCell, animated: Bool) {
        UIView.animate(withDuration: 0.25, animations: {
            cell.contentView.center = CGPoint(x: cell.bounds.midX, y: cell.origin.y)
            cell.deleteButton.center = CGPoint(x: cell.bounds.maxX + cell.DelBtnWidth / 2, y: cell.delOrigin.y)
        }) { (finished) in
            cell.origin = cell.contentView.center
            cell.delOrigin = cell.deleteButton.center
            cell.isLeft = false
            cell.shouldRight = cell.isLeft
            cell.removeGestureRecognizer(cell.tap)
        }
    }
    
}

extension CartProductCell: UIGestureRecognizerDelegate {
//    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
//        if (isLeft && shouldRight) || (!isLeft && !shouldRight) {
//            return false
//        }
//
//        return true
//    }
    
    override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer == pan {
            let translation = pan.translation(in: self)
            if fabs(translation.y) > fabs(translation.x) {
                return false
            }
        }
        
        return true
    }
}
