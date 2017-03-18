//
//  AmuseViewModel.swift
//  DYZB
//
//  Created by zhangzhifu on 2017/3/18.
//  Copyright © 2017年 seemygo. All rights reserved.
//

import UIKit

class AmuseViewModel : BaseViewModel{
    
}


extension AmuseViewModel {
    func loadAmuseData(finishedCallBack : @escaping () -> ()) {
        loadAnchorData(URLString: "http://capi.douyucdn.cn/api/v1/getHotRoom/2", finishedCallBack: finishedCallBack)
    }
}
