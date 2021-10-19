//
//  JMAlertManager.swift
//  Pods-ZJMAlertView_Example
//
//  Created by JunMing on 2020/3/30.
//

import UIKit
import SnapKit

open class JMAlertManager {
    private var backView = JMAlertBackView()
    public init(superView: UIView?, item: JMAlertModel) {
        addSubViews(superView: superView)
        if let container = getContainer(item: item) {
            backView.container = container
            backView.container.alertModel = item
            backView.backgroundColor = item.bkgColor
            backView.addSubview(backView.container)
        } else {
            assert(false, item.className + "⚠️⚠️⚠️⚠️⚠️未实现或未遵循协议")
        }
    }
    
    public init(superView: UIView?, container: JMAlertCompProtocol, item: JMAlertModel) {
        addSubViews(superView:superView)
        backView.container = container
        backView.container.alertModel = item
        backView.backgroundColor = item.bkgColor
        backView.addSubview(backView.container)
    }
    
    private func addSubViews(superView: UIView?) {
        if let view = superView {
            backView.frame = view.bounds
            view.addSubview(backView)
            backView.snp.makeConstraints { (make) in
                make.edges.equalTo(view)
            }
        } else {
            guard let window = UIApplication.shared.keyWindow else { return }
            backView.frame = window.bounds
            window.addSubview(backView)
            backView.snp.updateConstraints { (make) in
                make.edges.equalTo(window)
            }
        }
    }
    
    private func getContainer(item: JMAlertModel) -> JMAlertCompProtocol? {
        func classFromString(name: String) -> JMAlertCompProtocol? {
            if let appName = Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as! String? {
                let classStringName = appName + "." + name
                guard let newClass = NSClassFromString(classStringName) as? UIView.Type else {
                    return nil
                }
                return (newClass.init() as! JMAlertCompProtocol)
            }
            return nil;
        }
        return classFromString(name: item.className)
    }
    
    open func resetItem(item: JMAlertModel) {
        backView.container.alertModel = item
    }
    
    /// 开始布局
    open func update() {
        DispatchQueue.main.async {
            // 布局内容View的子view
            let size = self.backView.container.updateView()
            // 布局内容view
            self.backView.setupView(size:size)
            let deadline = DispatchTime.now()
            DispatchQueue.main.asyncAfter(deadline: deadline + 0.3) {
                // 更新内容view布局
                self.backView.updateBackView()
            }
        }
    }
    
    open func hide() {
        DispatchQueue.main.async {
            self.backView.container.remove(self.backView)
        }
    }
    
    deinit {
        print("⚠️⚠️⚠️类\(NSStringFromClass(type(of: self)))已经释放")
    }
}

extension JMAlertManager {
    public static func jmHide(_ superView:UIView?) {
        if let view = superView {
            view.subviews.forEach({ (view) in
                if view.isKind(of: JMAlertBackView.self) {
                    if let back = view as? JMAlertBackView  {
                        back.container.remove(back)
                    }
                }
            })
        }else {
            guard let window = UIApplication.shared.keyWindow else { return }
            window.subviews.forEach({ (view) in
                if view.isKind(of: JMAlertBackView.self) {
                    if let back = view as? JMAlertBackView  {
                        back.container.remove(back)
                    }
                }
            })
        }
    }
    
    public static func jmShowAnimation(_ superView:UIView?, showClose:Bool = false) {
        let loading = JMAlertViewLoading()
        let sheetItem = JMAlertModel(className: "JMAlertViewLoading")
        sheetItem.bkgColor = UIColor.clear
        let sheetManager = JMAlertManager(superView:superView, container: loading, item: sheetItem)
        sheetItem.sheetType = .center
        sheetItem.showClose = showClose
        sheetManager.update()
    }
    
    public static func jmShowNotify(_ superView:UIView?) {
        
    }
    
    public static func jmShowSheet(_ superView:UIView?, action:((JMAlertItem)->Void)?) {
        
    }
    
    public static func jmShowAlert(_ superView:UIView?, action:((JMAlertItem?)->Void)?) {
        let loading = JMAlertInfoView()
        let sure = JMAlertItem(title: "确定", icon: nil)
        sure.action = { action?($0) }
        let cancle = JMAlertItem(title: "取消", icon: nil)
        cancle.action = { action?($0) }
        
        let sheetItem = JMAlertModel(className: "JMAlertViewLoading")
        sheetItem.items = [sure,cancle]
        sheetItem.title = "确定"
        sheetItem.subTitle = "是否确认删除"
        let sheetManager = JMAlertManager(superView:superView, container: loading,item: sheetItem)
        sheetItem.sheetType = .center
        sheetManager.update()
    }
}
