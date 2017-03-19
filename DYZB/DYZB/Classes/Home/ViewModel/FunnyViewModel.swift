//
//  FunnyViewModel.swift
//  DYZB
//
//  Created by zhangzhifu on 2017/3/19.
//  Copyright © 2017年 seemygo. All rights reserved.
//

import UIKit

class FunnyViewModel : BaseViewModel {

}


extension FunnyViewModel {
    func loadFunnyData(finishedCallBack : @escaping () -> ()) {
        loadAnchorData(isGroupData: false, URLString: "http://capi.douyucdn.cn/api/v1/getColumnRoom/3", parameters: ["limit" : 30, "offset" : 0], finishedCallBack: finishedCallBack)
    }
}
