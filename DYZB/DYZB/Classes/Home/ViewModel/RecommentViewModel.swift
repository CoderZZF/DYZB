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
    lazy var anchorGroups : [AnchorGroup] = [AnchorGroup]()
    lazy var cycleModels : [CycleModel] = [CycleModel]()
    fileprivate lazy var bigDataGroup : AnchorGroup = AnchorGroup()
    fileprivate lazy var prettyGroup : AnchorGroup = AnchorGroup()
}


// MARK:- 发送网络请求
extension RecommentViewModel {
    // 请求推荐数据
    func requestData(_ finishedCallBack : @escaping () -> ()) {
        // 1. 定义参数
        let parameters = ["limit" : "4", "offset" : "0", "time" : Date.getCurrentTime()]
        
        // 2. 创建group
        let dGroup = DispatchGroup()
        
        // 3. 请求第一部分推荐数据
        dGroup.enter()
        //http://capi.douyucdn.cn/api/v1/getbigDataRoom?time=1489733669
        NetworkTools.requestData(.get, URLString: "http://capi.douyucdn.cn/api/v1/getbigDataRoom", parameters: ["time" : Date.getCurrentTime()]) { (result) in
            // 1. 将result转成字典类型
            guard let resultDict = result as? [String : NSObject] else {
                return
            }
            
            // 2. 根据data该key获取数组
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else {
                return
            }
            
            // 3. 遍历字典,并且转成模型对象
            // 3.1 设置组的属性
            self.bigDataGroup.tag_name = "热门"
            self.bigDataGroup.icon_name = "home_header_hot"
            
            // 3.2 获取主播数据
            for dict in dataArray {
                let anchor = AnchorModel(dict: dict)
                self.bigDataGroup.anchors.append(anchor)
            }
            
            // 3.3 离开组
            dGroup.leave()
//            print("热门数据")
        }
        
        // 4. 请求第二部分颜值数据
        dGroup.enter()
        NetworkTools.requestData(.get, URLString: "http://capi.douyucdn.cn/api/v1/getVerticalRoom", parameters: parameters) { (result) in
            // 1. 将result转成字典类型
            guard let resultDict = result as? [String : NSObject] else {
                return
            }
            
            // 2. 根据data该key获取数组
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else {
                return
            }
            
            // 3. 遍历字典,并且转成模型对象
            // 3.1 设置组的属性
            self.prettyGroup.tag_name = "颜值"
            self.prettyGroup.icon_name = "home_header_phone"
            
            // 3.2 获取主播数据
            for dict in dataArray {
                let anchor = AnchorModel(dict: dict)
                self.prettyGroup.anchors.append(anchor)
            }
            
            // 3.3 离开组
            dGroup.leave()
//            print("颜值数据")
        }
        
        // 5. 请求游戏数据
        // http://capi.douyucdn.cn/api/v1/getHotCate?limit=4&offset=0&time=1489733669
//        print(NSDate.getCurrentTime())
        dGroup.enter()
        NetworkTools.requestData(.get, URLString: "http://capi.douyucdn.cn/api/v1/getHotCate", parameters: parameters) { (result) in
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
            // 4 离开组
            dGroup.leave()
//            print("游戏数据")
        }
        
        // 6. 所有的数据都请求到,然后进行排序
        dGroup.notify(queue: DispatchQueue.main) { 
//            print("所有的数组都请求到了")
            self.anchorGroups.insert(self.prettyGroup, at: 0)
            self.anchorGroups.insert(self.bigDataGroup, at: 0)
            
            finishedCallBack()
        }
    }
    
    // 请求无限轮播数据
    //
    func reqeustCycleData(_ finishedCallBack : @escaping () -> ()) {
        NetworkTools.requestData(.get, URLString: "http://www.douyutv.com/api/v1/slide/6", parameters: ["version" : "2.300"]) { (result) in
            // 1. 获取整体字典数据
            guard let resultDict = result as? [String : NSObject] else { return }
            
            // 2. 根据data的key获取数据
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else { return }
            
            // 3. 字典转模型
            for dict in dataArray {
                self.cycleModels.append(CycleModel(dict: dict))
            }
            
            finishedCallBack()
        }
    }
}
