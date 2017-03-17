//
//  CollectionNormalCell.swift
//  DYZB
//
//  Created by zhangzhifu on 2017/3/17.
//  Copyright © 2017年 seemygo. All rights reserved.
//

import UIKit

class CollectionNormalCell: CollectionBaseCell {
    // MARK:- 控件属性
    @IBOutlet weak var roomnameLabel: UILabel!
    
    // MARK:- 定义模型属性
    override var anchor : AnchorModel? {
        didSet {
            // 1. 将属性传递给父类
            super.anchor = anchor
            
            // 2. 房间名称
            roomnameLabel.text = anchor?.room_name
        }
    }

}
