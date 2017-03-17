//
//  AnchorGroup.swift
//  DYZB
//
//  Created by zhangzhifu on 2017/3/17.
//  Copyright © 2017年 seemygo. All rights reserved.
//

import UIKit

class AnchorGroup: NSObject {
    // 该组中对应的房间信息
    var room_list : [[String : NSObject]]? {
        didSet {
            // 判断room_list是否有值
            guard let room_list = room_list else { return }
            
            for dict in room_list {
                anchors.append(AnchorModel(dict: dict))
            }
        }
    }
    // 组显示的标题
    var tag_name : String = ""
    // 组显示的图标
    var icon_name : String = "home_header_normal"
    // 游戏对应的图标
    var icon_url : String = ""
    
    // 定义主播模型对象的数组
    lazy var anchors : [AnchorModel] = [AnchorModel]()
    
    override init() {
        
    }
    
    init(dict : [String : NSObject]) {
        super.init()
        
        setValuesForKeysWithDictionary(dict)
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
    }
    
    /*
    // 重写KVC
    override func setValue(value: AnyObject?, forKey key: String) {
        if key == "room_list" {
            if let dataArray = value as? [[String : NSObject]] {
                for dict in dataArray {
                    anchors.append(AnchorModel(dict: dict))
                }
            }
        }
    }*/
}
