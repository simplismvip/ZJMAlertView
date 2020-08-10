//
//  JMAlertItem.swift
//  Pods-ZJMAlertView_Example
//
//  Created by JunMing on 2020/3/30.
//

import UIKit

public enum JMAlertDircation {
    case top,bottom,center,animation,sheet
}

open class JMAlertItem {
    open var action:((_ item:JMAlertItem)->Void)?
    open var title:String?
    open var subtitle:String?
    open var icon:UIImage?
    open var eventName:String?
    open var font:UIFont?
    open var textColor = UIColor.gray
    open var textAli = NSTextAlignment.left
    open var attrStr:NSAttributedString?
    open var tag = 100
    // 这个是谷歌广告使用
    open var rootVc:UIViewController?
    
    public init(title:String,icon:UIImage?) {
        self.title = title
        self.icon = icon
    }
}

open class JMAlertModel {
    open var className:String
    open var items:[JMAlertItem]?
    // 是否显示关闭按钮
    open var showClose = false
    // 是否允许点击屏幕移除
    open var touchClose = false
    // 是否能透传点击消息
    open var canPierce = false
    open var sheetType = JMAlertDircation.center
    open var bkgColor = UIColor.black.withAlphaComponent(0.5)
    open var title:String?
    open var subTitle:String?
    open var content:String?
    
    public init(className:String) {
        self.className = className
    }
}
