//
//  JMAlertItem.swift
//  Pods-ZJMAlertView_Example
//
//  Created by JunMing on 2020/3/30.
//

import UIKit

public enum JMAlertDircation {
    case top, bottom, center, animation, sheet, topRight
}

public class JMAlertItem {
    public var action: ((_ item: JMAlertItem?)->Void)?
    public var title: String?
    public var subtitle: String?
    public var icon: UIImage?
    public var eventName: String?
    public var font: UIFont?
    public var textColor = UIColor.gray
    public var textAli = NSTextAlignment.left
    public var attrStr: NSAttributedString?
    public var tag = 100
    // 这个是谷歌广告使用
    public var rootVc: UIViewController?
    public init(title: String, icon: UIImage?) {
        self.title = title
        self.icon = icon
    }
}

public class JMAlertModel {
    public var className: String
    public var items: [JMAlertItem]?
    // 是否显示关闭按钮
    public var showClose = false
    // 是否允许点击屏幕移除
    public var touchClose = false
    // 是否能透传点击消息
    public var canPierce = false
    public var sheetType = JMAlertDircation.center
    public var bkgColor = UIColor.black.withAlphaComponent(0.5)
    public var title: String?
    public var subTitle: String?
    public var content: String?
    public init(className: String) {
        self.className = className
    }
}
