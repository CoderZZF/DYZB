//
//  RecommendViewController.swift
//  DYZB
//
//  Created by zhangzhifu on 2017/3/16.
//  Copyright © 2017年 seemygo. All rights reserved.
//

import UIKit

private let kItemMargin : CGFloat = 10
private let kItemW = (kScreenW - 3 * kItemMargin) / 2
private let kNormalItemH = kItemW * 3 / 4
private let kPrettyItemH = kItemW * 4 / 3
private let kHeaderViewH : CGFloat = 50

private let kNormalCellID = "kNormalCellID"
private let kHeaderCellID = "kHeaderCellID"
private let kPrettyCellID = "kPrettyCellID"

class RecommendViewController: UIViewController {
    // MARK:- 懒加载属性
    private lazy var recommentVM : RecommentViewModel = RecommentViewModel()
    private lazy var collectionView : UICollectionView = {[unowned self] in
        // 1. 创建布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kNormalItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = kItemMargin
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderViewH)
        layout.sectionInset = UIEdgeInsets(top: 0, left: kItemMargin, bottom: 0, right: kItemMargin)
        
        // 2. 创建UICollectionView
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.whiteColor()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.registerNib(UINib(nibName: "CollectionNormalCell", bundle: nil), forCellWithReuseIdentifier: kNormalCellID)
        collectionView.registerNib(UINib(nibName: "CollectionPrettyCell", bundle: nil), forCellWithReuseIdentifier: kPrettyCellID)
        collectionView.registerNib(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderCellID)
        collectionView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        
        return collectionView
    }()
    
    // MARK:- 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 设置UI界面
        setupUI()
        
        // 发送网络请求
        loadData()
    }
}


// MARK:- 设置UI界面内容
extension RecommendViewController {
    private func setupUI() {
        // 1. 将UICollectionView添加到控制器的View
        view.addSubview(collectionView)
    }
}

// MARK:- 请求数据
extension RecommendViewController {
    private func loadData() {
        recommentVM.requestData { 
            self.collectionView.reloadData()
        }
    }
}


// MARK:- 遵守UICollectionViewDataSource
extension RecommendViewController : UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return recommentVM.anchorGroups.count
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let group = recommentVM.anchorGroups[section]
        
        return group.anchors.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        // 1. 取出模型
        let group = recommentVM.anchorGroups[indexPath.section]
        let anchor = group.anchors[indexPath.item]
        
        // 2. 定义cell
        var cell : CollectionBaseCell!
        
        // 3. 取出cell
        if indexPath.section == 1 {
            cell = collectionView.dequeueReusableCellWithReuseIdentifier(kPrettyCellID, forIndexPath: indexPath) as! CollectionPrettyCell
        } else {
            cell = collectionView.dequeueReusableCellWithReuseIdentifier(kNormalCellID, forIndexPath: indexPath) as! CollectionNormalCell
        }
        
        // 4. 将模型赋值给cell
        cell.anchor = anchor
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        // 1. 取出section的headerView
        let headerView = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: kHeaderCellID, forIndexPath: indexPath) as! CollectionHeaderView
        
        // 2. 取出模型
        headerView.group = recommentVM.anchorGroups[indexPath.section]
        
        return headerView;
    }
    
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        if indexPath.section == 1 {
            return CGSize(width: kItemW, height: kPrettyItemH)
        }
        return CGSize(width: kItemW, height: kNormalItemH)
    }
}