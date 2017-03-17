//
//  RecommentViewModel.swift
//  DYZB
//
//  Created by zhangzhifu on 2017/3/17.
//  Copyright © 2017年 seemygo. All rights reserved.
//

import UIKit

class RecommentViewModel {
    // MARK:- 懒加载属性
    private lazy var anchorGroups : [AnchorGroup] = [AnchorGroup]()
}


// MARK:- 发送网络请求
extension RecommentViewModel {
    func requestData() {
        // 1. 请求第一部分推荐数据
        
        // 2. 请求第二部分颜值数据
        
        // 3. 请求游戏数据
        // http://capi.douyucdn.cn/api/v1/getHotCate?limit=4&offset=0&time=1489733669
//        print(NSDate.getCurrentTime())
        NetworkTools.requestData(.GET, URLString: "http://capi.douyucdn.cn/api/v1/getHotCate", parameters: ["limit" : "4", "offset" : "0", "time" : NSDate.getCurrentTime()]) { (result) in
            // 1. 将result转成字典类型
            guard let resultDict = result as? [String : NSObject] else {
                return
            }
            
            // 2. 根据data该key获取数组
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else {
                return
            }
            
            // 3. 遍历数组,获取字典,并且将字典转成模型对象
            for dict in dataArray {
                let group = AnchorGroup(dict: dict)
                self.anchorGroups.append(group)
            }
            
            for group in self.anchorGroups {
                for anchor in group.anchors {
                    print(anchor.nickname)
                }
                print("----")
            }
        }
    }
}