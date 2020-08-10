//
//  AlertViewTest.swift
//  ZJMAlertView_Example
//
//  Created by JunMing on 2020/3/30.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import ZJMAlertView
import ZJMKit

class jmBaseSheetView: UIView {
    deinit { print("‼️‼️‼️类已经释放") }
}

// MARK: -- BookInfoShare
class BookInfoShare: jmBaseSheetView, JMAlertCompProtocol {
    var alertModel: JMAlertModel? { willSet { } }
    private var line = UIView(frame: CGRect.zero)
    private var title = UILabel(frame: CGRect.zero)
    private var subtitle = UILabel(frame: CGRect.zero)
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(title)
        addSubview(subtitle)
        addSubview(line)
        
        title.text = "开始测试"
        subtitle.text = "你可以利用使用一个函数的类型例如 (Int, Int) -> Int作为其他函数的形式参数类型。这允许你预留函数的部分实现从而让函数的调用者在调用函数的时候提供。"
        configAlert()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configAlert() {
        subtitle.numberOfLines = 0
        line.backgroundColor = UIColor.jmRandColor
        title.backgroundColor = UIColor.jmRandColor
        subtitle.backgroundColor = UIColor.jmRandColor
        backgroundColor = UIColor.jmRGB(255,255,255)
        layer.cornerRadius = 10
        layer.masksToBounds = true
    }
    
    // MARK: 实现协议
    func updateView() -> CGSize {
        line.snp.makeConstraints { (make) in
//            make.height.equalTo(self)
            make.top.bottom.equalTo(self)
            make.width.equalTo(120)
            make.left.equalTo(self)
        }
        
        title.snp.makeConstraints { (make) in
            make.left.equalTo(line.snp.right).offset(10)
            make.height.equalTo(30)
            make.top.equalTo(line.snp.top).offset(20)
        }
        
        subtitle.snp.makeConstraints { (make) in
            make.left.equalTo(line.snp.right).offset(10)
            make.top.equalTo(title.snp.bottom)
            make.bottom.equalTo(snp.bottom).offset(-20)
        }
        
        return CGSize(width: JMTools.jmWidth()-40, height: 250)
    }
}
