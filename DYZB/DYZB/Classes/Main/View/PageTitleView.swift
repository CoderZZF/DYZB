//
//  PageTitleView.swift
//  DYZB
//
//  Created by zhangzhifu on 2017/3/15.
//  Copyright © 2017年 seemygo. All rights reserved.
//

import UIKit

protocol PageTitleViewDelegate : class {
    func pageTitleView(titleView : PageTitleView, selectedIndex index : Int)
}

private let kScrollLineH : CGFloat = 2

class PageTitleView: UIView {
    // MARK:- 定义属性
    private var previousIndex : Int = 0
    private var titles : [String]
    weak var delegate : PageTitleViewDelegate?
    
    // MARK:- 懒加载属性
    private lazy var titleLabels : [UILabel] = [UILabel]()
    private lazy var scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.bounces = false
        return scrollView
    }()
    private lazy var scrollLine : UIView = {
        let scrollLine = UIView()
        scrollLine.backgroundColor = UIColor.orangeColor()
        return scrollLine
    }()
    
    // MARK:- 自定义一个构造函数
    init(frame: CGRect, titles : [String]) {
        self.titles = titles
        
        super.init(frame: frame)
        
        // 设置UI界面
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}


// MARK:- 设置UI界面
extension PageTitleView {
    private func setupUI() {
        // 1. 添加UIScrollView
        addSubview(scrollView)
        scrollView.frame = bounds
        
        // 2. 添加title对应的label
        setupTitleLabels()
        
        // 3. 设置底线和指示器
        setupBottomLineAndScrollLine()
    }
    
    private func setupTitleLabels() {
        // 确定一些label的frame值
        let labelW : CGFloat = frame.width / CGFloat(titles.count)
        let labelH : CGFloat = frame.height - kScrollLineH
        let labelY : CGFloat = 0
        
        for (index, title) in titles.enumerate() {
            // 1. 创建UILabel
            let label = UILabel()
            
            // 2. 设置label的属性
            label.text = title
            label.tag = index
            label.font = UIFont.systemFontOfSize(16)
            label.textColor = UIColor.darkGrayColor()
            label.textAlignment = .Center
            
            // 3. 设置label的frame
            let labelX : CGFloat = labelW * CGFloat(index)
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            
            // 4. 将label添加到scrollView中
            scrollView.addSubview(label)
            titleLabels.append(label)
            
            // 5. 给label添加手势
            label.userInteractionEnabled = true
            let tapGes = UITapGestureRecognizer(target: self, action: #selector(titleLabelClick(_:)))
            label.addGestureRecognizer(tapGes)
        }
    }
    
    private func setupBottomLineAndScrollLine() {
        // 1. 添加底线
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.lightGrayColor()
        let lineH : CGFloat = 0.5
        bottomLine.frame = CGRect(x: 0, y: frame.height - lineH, width: frame.width, height: lineH)
        addSubview(bottomLine)
        
        // 2. 添加scrollLine
        // 2.1 获取第一个label
        guard let firstLabel = titleLabels.first else { return }
        firstLabel.textColor = UIColor.orangeColor()
        
        // 2.2 设置scrollView的属性
        scrollView.addSubview(scrollLine)
        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height - kScrollLineH, width: firstLabel.frame.width, height: kScrollLineH)
    }
}

// MARK:- 监听label的点击
extension PageTitleView {
    @objc private func titleLabelClick(tapGes : UITapGestureRecognizer) {
        // 1. 获取当前label
        guard let currentLabel = tapGes.view as? UILabel else { return }
        
        // 2. 获取之前的label
        let previousLabel = titleLabels[previousIndex]
        
        // 3. 切换文字的颜色
        currentLabel.textColor = UIColor.orangeColor()
        previousLabel.textColor = UIColor.darkGrayColor()
        
        // 4. 保存最新label的下标值
        previousIndex = currentLabel.tag
        
        // 5. 滚动条位置发生改变
        let scrollLineX = CGFloat(previousIndex) * scrollLine.frame.width
        UIView.animateWithDuration(0.15) {
            self.scrollLine.frame.origin.x = scrollLineX
        }
        
        // 6. 通知代理做事情
        delegate?.pageTitleView(self, selectedIndex: previousIndex)
    }
}


// MARK:- 对外暴露的方法
extension PageTitleView {
    func setTitleWithProgress(progress : CGFloat, sourceIndex : Int, targetIndex : Int) {
        
    }
}



