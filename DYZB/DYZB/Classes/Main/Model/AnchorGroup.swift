//
//  AnchorGroup.swift
//  DYZB
//
//  Created by zhangzhifu on 2017/3/17.
//  Copyright © 2017年 seemygo. All rights reserved.
//

import UIKit

class AnchorGroup: BaseGameModel {
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
    // 组显示的图标
    var icon_name : String = "home_header_normal"
    
    // 定义主播模型对象的数组
    lazy var anchors : [AnchorModel] = [AnchorModel]()
}
