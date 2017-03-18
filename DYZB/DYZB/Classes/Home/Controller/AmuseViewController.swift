//
//  AmuseViewController.swift
//  DYZB
//
//  Created by zhangzhifu on 2017/3/18.
//  Copyright © 2017年 seemygo. All rights reserved.
//

import UIKit

class AmuseViewController: BaseAnchorViewController {
    // MARK: 懒加载属性
    fileprivate lazy var amuseVM : AmuseViewModel = AmuseViewModel()
}



// MARK:- 请求数据
extension AmuseViewController {
    override func loadData() {
        // 1. 给父类中的viewmodel赋值
        baseVM = amuseVM
        
        // 2. 请求数据
        amuseVM.loadAmuseData {
            self.collectionView.reloadData()
        }
    }
}





