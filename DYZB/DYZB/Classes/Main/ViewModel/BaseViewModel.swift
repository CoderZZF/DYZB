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
    func loadAnchorData(URLString : String, parameters : [String : Any]? = nil, finishedCallBack : @escaping () -> ()) {
        NetworkTools.requestData(.get, URLString: URLString, parameters: parameters) { (result) in
            // 1. 对结果进行处理
            guard let resultDict = result as? [String : Any] else { return }
            guard let dataArray = resultDict["data"] as? [[String : Any]] else { return }
            
            // 2. 遍历数组中的字典
            for dict in dataArray {
                self.anchorGroups.append(AnchorGroup(dict: dict))
            }
            
            // 3. 回调
            finishedCallBack()
        }
    }
}
