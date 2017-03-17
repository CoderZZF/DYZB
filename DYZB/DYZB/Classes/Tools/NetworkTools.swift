//
//  NetworkTools.swift
//  Alamofire测试
//
//  Created by zhangzhifu on 2017/3/17.
//  Copyright © 2017年 seemygo. All rights reserved.
//

import UIKit
import Alamofire

enum MethodType {
    case GET
    case POST
}

/*
 一个零件的组装操作有三个步骤,需要两个人(外部A和内部B)执行完成,顺序是A将原料传递给B,B初步组装后再传递给A,A进行最后一步组装,任务完成.
 B有时会被别人叫走,不能确定何时有空,才能完成第二步组装,为了及时完成整体组装任务,B和A说:"我把第二步组装完成后的模型给你,你据此完成第三步,然后把成品给我,等我有空把第二步完成后再将实物替换之前给你的模型,这样你不需要等待咱们也能在第一时间完成整体的组装任务了
 */

/*
 内部定义闭包:老公和老婆说:"我今天接了一个活儿,事成之后能赚一笔钱,你这几天没事可以去商场里转转,有看上的衣服记下来,回头钱下来给你买.
 外部实现闭包:老婆告诉老公想买什么.
 内部调用闭包:钱下来后,老公带着老婆去买衣服.
 */
class NetworkTools {
    class func requestData(type : MethodType, URLString : String, parameters : [String : NSString]? = nil, finishedCallBack : (result : AnyObject)-> ()) {
        // 1. 获取类型
        let method = type == .GET ? Method.GET : Method.POST
        
        // 2. 发送网络请求
        Alamofire.request(method, URLString, parameters: parameters).responseJSON { (response) in
            // 3. 获取结果
            guard let result = response.result.value else {
                print(response.result.error)
                return
            }
            
            // 4. 将结果回调出去
            finishedCallBack(result: result)
        }
    }
}
