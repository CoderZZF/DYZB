//
//  UIBarButtonItem-Extension.swift
//  DYZB
//
//  Created by zhangzhifu on 2017/3/15.
//  Copyright © 2017年 seemygo. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    /*
    class func createItem(imageName : String, highImageName : String, size : CGSize) -> UIBarButtonItem {
        
        let btn = UIButton()
        btn.setImage(UIImage(named: imageName), forState: .Normal)
        btn.setImage(UIImage(named: highImageName), forState: .Highlighted)
        
        btn.frame = CGRect(origin: CGPointZero, size: size)
        
        return UIBarButtonItem(customView: btn)
    }*/
    
    // 便利构造函数 1> 以convenience修饰 2> 在构造函数中必须明确调用一个设计的构造函数
    convenience init(imageName : String, highImageName : String = "", size : CGSize = CGSizeZero) {
        // 1. 创建UIButton
        let btn = UIButton()
        
        // 2. 设置图片
        btn.setImage(UIImage(named: imageName), forState: .Normal)
        if highImageName != "" {
            btn.setImage(UIImage(named: highImageName), forState: .Highlighted)
        }
        
        // 3. 设置尺寸
        if size == CGSizeZero {
            btn.sizeToFit()
        } else {
            btn.frame = CGRect(origin: CGPointZero, size: size)
        }
        // 4. 创建UIBarButtonItem
        self.init(customView: btn)
    }
}
