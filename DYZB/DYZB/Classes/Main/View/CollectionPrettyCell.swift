//
//  CollectionPrettyCell.swift
//  DYZB
//
//  Created by zhangzhifu on 2017/3/17.
//  Copyright © 2017年 seemygo. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionPrettyCell: CollectionBaseCell {
    // MARK:- 控件属性
    @IBOutlet weak var cityBtn: UIButton!

    // MARK:- 定义模型属性
    override var anchor : AnchorModel? {
        didSet {
            // 1. 将属性传递给父类
            super.anchor = anchor
            
            // 2. 显示所在城市
            cityBtn.setTitle(anchor?.anchor_city, forState: .Normal)
       
        }
    }

}
