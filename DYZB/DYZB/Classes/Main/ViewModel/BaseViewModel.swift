//
//  BaseViewModel.swift
//  DYZB
//
//  Created by zhangzhifu on 2017/3/18.
//  Copyright © 2017年 seemygo. All rights reserved.
//

import UIKit

class BaseViewModel {
    lazy var anchorGroups : [AnchorGroup] = [AnchorGroup]()
}


extension BaseViewModel {
    func loadAnchorData(isGroupData : Bool, URLString : String, parameters : [String : Any]? = nil, finishedCallBack : @escaping () -> ()) {
        NetworkTools.requestData(.get, URLString: URLString, parameters: parameters) { (result) in
            // 1. 对结果进行处理
            guard let resultDict = result as? [String : Any] else { return }
            guard let dataArray = resultDict["data"] as? [[String : Any]] else { return }
            
            // 2. 判断是否是分组数据
            if isGroupData {
                // 2. 遍历数组中的字典
                for dict in dataArray {
                    self.anchorGroups.append(AnchorGroup(dict: dict))
                }
            } else {
                // 2.1 创建组
                let group = AnchorGroup()
                // 2.2 遍历dataArray中所有的字典
                for dict in dataArray {
                    group.anchors.append(AnchorModel(dict: dict))
                }
                // 2.3 将group添加到anchorGroup
                self.anchorGroups.append(group)
            }
            
            
            // 3. 回调
            finishedCallBack()
        }
    }
}
