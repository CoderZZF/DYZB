//
//  AmuseMenuViewCell.swift
//  DYZB
//
//  Created by zhangzhifu on 2017/3/18.
//  Copyright © 2017年 seemygo. All rights reserved.
//

import UIKit

private let kGameCellID = "kGameCellID"

class AmuseMenuViewCell: UICollectionViewCell {
    // MARK: 控件属性
    @IBOutlet weak var collectionView: UICollectionView!

    // MARK: 从xib中加载
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.register(UINib(nibName: "CollectionGameCell", bundle: nil), forCellWithReuseIdentifier: kGameCellID)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let itemW = collectionView.bounds.size.width / 4
        let itemH = collectionView.bounds.size.height / 2
        layout.itemSize = CGSize(width: itemW, height: itemH)
    }

}


extension AmuseMenuViewCell : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // 1. 取出cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameCellID, for: indexPath)
        
        // 2. 给cell设置数据
        cell.backgroundColor = UIColor.randomColor()
        
        return cell
    }
}
