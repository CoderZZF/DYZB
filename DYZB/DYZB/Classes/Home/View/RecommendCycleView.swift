//
//  RecommendCycleView.swift
//  DYZB
//
//  Created by zhangzhifu on 2017/3/17.
//  Copyright © 2017年 seemygo. All rights reserved.
//

import UIKit

private let kCycleCellID = "kCycleCellID"

class RecommendCycleView: UIView {
    // MARK:- 定义属性
    var cycleModels : [CycleModel]? {
        didSet {
            // 1. 刷新collectionView
            collectionView.reloadData()
            
            // 2. 设置pagecontrol的个数
            pageControl.numberOfPages = cycleModels?.count ?? 0
        }
    }
    
    // MARK:- 控件属性
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    // MARK:- 系统回调
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // 设置该控件不随着父控件的拉伸而拉伸
        autoresizingMask = .None
        
        // 注册cell
        collectionView.registerNib(UINib(nibName: "CollectionCycleCell",bundle: nil), forCellWithReuseIdentifier: kCycleCellID)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // 设置collectionView的layout
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = collectionView.bounds.size
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .Horizontal
        collectionView.pagingEnabled = true
    }
    
}

// MARK:- 提供一个快速创建的类方法
extension RecommendCycleView {
    class func recommendCycleView() -> RecommendCycleView {
        return NSBundle.mainBundle().loadNibNamed("RecommendCycleView", owner: nil, options: nil).first as! RecommendCycleView
    }
}

// MARK:- 遵守UICollectionView的数据源协议
extension RecommendCycleView : UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cycleModels?.count ?? 0
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cycleModel = cycleModels![indexPath.item]
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(kCycleCellID, forIndexPath: indexPath) as! CollectionCycleCell
        
        cell.cycleModel = cycleModel
        
        return cell
    }
}

// MARK:- 遵守UICollectionView的代理协议
extension RecommendCycleView : UICollectionViewDelegate {
    func scrollViewDidScroll(scrollView: UIScrollView) {
        // 1. 获取滚动的偏移量
        let offsetX = scrollView.contentOffset.x + scrollView.bounds.width * 0.5
        
        // 2. 计算pagecontroldecurrentIndex
        pageControl.currentPage = Int(offsetX / scrollView.bounds.width)
    }
}