//
//  CategoryCell.swift
//  ShiKe
//
//  Created by 沈永聪 on 2018/6/8.
//  Copyright © 2018年 沈永聪. All rights reserved.
//

import UIKit

class CategoryCell: UITableViewCell {
    //MARK:- Members
    let coll_reuseIdentifier = "ProductCell"
    
    var viewModel: CategoryViewModel?
    var addBlock: ((ProductViewModel) -> ())?
    
    private var collectionView: UICollectionView!
    
    //MARK:- Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = UIColor.white
        self.selectionStyle = .none
        
        setupSubviews()
        configLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- Setup
    func setupSubviews() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 10
        flowLayout.minimumInteritemSpacing = 10
        flowLayout.itemSize = CGSize(width: 116, height: 180)
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        flowLayout.scrollDirection = .horizontal
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = UIColor.white
        collectionView.register(ProductCell.self, forCellWithReuseIdentifier: coll_reuseIdentifier)
        self.contentView.addSubview(collectionView)
    }
    
    //MARK:- Layout
    func configLayout() {
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.contentView)
        }
    }

}

extension CategoryCell: UICollectionViewDataSource {
    //MARK:- UICollectionViewDataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.productList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: coll_reuseIdentifier, for: indexPath) as! ProductCell
        cell.viewModel = viewModel?.productList?[indexPath.item]
        cell.addBlock = { [weak self](viewModel) in
            if let block = self?.addBlock {
                block(viewModel)
            }
        }
        
        return cell
    }
}

extension CategoryCell: UICollectionViewDelegate {
    //MARK:- UICollectionViewDelegate
}
