//
//  JMAlertProtocol.swift
//  Pods-ZJMAlertView_Example
//
//  Created by JunMing on 2020/3/30.
//

import Foundation

// MARK: -- 自定义展现 协议
public protocol JMAlertCompProtocol:UIView {
//    associatedtype container
    /// 移除Alert，非必须实现，有默认实现
    func remove(_ backView: JMAlertBackView)
    /// 布局Alert，必须实现
    func updateView() -> CGSize
    /// 数据，非必须实现
    var alertModel: JMAlertModel? { get set }
}

public extension JMAlertCompProtocol {
    func remove(_ backView:JMAlertBackView) {
        if let contain = backView.container {
            let offset = contain.jmHeight
            switch backView.container.alertModel?.sheetType {
            case .top?:
                contain.snp.updateConstraints { (make) in
                    if #available(iOS 11.0, *) {
                        make.bottom.equalTo(backView.safeAreaLayoutGuide.snp.top).offset(offset - 20)
                    }else{
                        make.bottom.equalTo(backView.snp.top).offset(offset - 20)
                    }
                }
            case .bottom?:
                contain.snp.updateConstraints { (make) in
                    if #available(iOS 11.0, *) {
                        make.top.equalTo(backView.safeAreaLayoutGuide.snp.bottom).offset(offset)
                    }else{
                        make.top.equalTo(backView.snp.bottom).offset(offset)
                    }
                }
            default:
                print("top")
            }
        }
        UIView.animate(withDuration: 0.3, animations: {
            backView.alpha = 0.0
            backView.layoutIfNeeded()
        }) { _ in
            backView.removeFromSuperview()
        }
    }
}
