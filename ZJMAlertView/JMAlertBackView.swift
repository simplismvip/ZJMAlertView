//
//  JMAlertBackView.swift
//  Pods-ZJMAlertView_Example
//
//  Created by JunMing on 2020/3/30.
//

import UIKit
import SnapKit
import ZJMKit

open class JMAlertBackView: UIView {
    var container:JMAlertCompProtocol!
    var close = UIButton(type: .system)
    let bkgView = UIView()
    override init(frame: CGRect) {
        super.init(frame: frame)
        alpha = 0.0
        close.setBackgroundImage(UIImage.imageNamed(bundleName: "close"), for: .normal)
        close.tintColor = UIColor.white
        close.addTarget(self, action: #selector(closeAction), for: .touchUpInside)
        addSubview(close)
    }
    
    override open func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if !container.alertModel!.canPierce { return super.hitTest(point, with: event) }
        if isHidden || alpha < 0.01 || isUserInteractionEnabled { return nil }
        let view = super.hitTest(point, with: event)
        if (view?.isEqual(self))! {
            return nil
        }else {
            return view
        }
    }
    
    @objc func closeAction() {
        container.remove(self)
    }
    
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touchClose = container.alertModel?.touchClose, touchClose {
            container.remove(self)
        }
    }
    
    // 更新布局
    func updateBackView() {
        let offset = container.jmHeight
        switch container.alertModel?.sheetType {
        case .top?:
            container.snp.updateConstraints { (make) in
                if #available(iOS 11.0, *) {
                    make.bottom.equalTo(safeAreaLayoutGuide.snp.top).offset(offset + 20)
                }else{
                    make.bottom.equalTo(snp.top).offset(offset + 20)
                }
            }
        case .bottom?:
            container.snp.updateConstraints { (make) in
                if #available(iOS 11.0, *) {
                    make.top.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-offset)
                }else{
                    make.top.equalTo(snp.bottom).offset(-offset)
                }
            }
            
            bkgView.snp.updateConstraints { (make) in
                make.top.equalTo(snp.bottom).offset(-(offset+UIDevice.footerSafeAreaHeight))
            }
        default:
            print("top")
        }
        
        container.setNeedsUpdateConstraints()
        UIView.animate(withDuration: 0.3) {
            self.container.superview?.alpha = 1.0
            self.container.superview?.layoutIfNeeded()
        }
    }
    
    // 开始布局
    func setupView(size:CGSize) {
        switch container.alertModel?.sheetType {
        case .top?:
            container.snp.makeConstraints { (make) in
                make.size.equalTo(size)
                make.centerX.equalTo(snp.centerX)
                if #available(iOS 11.0, *) {
                    make.bottom.equalTo(safeAreaLayoutGuide.snp.top)
                }else{
                    make.bottom.equalTo(snp.top)
                }
            }
        case .bottom?:
            container.snp.remakeConstraints { (make) in
                make.centerX.equalTo(snp.centerX)
                make.size.equalTo(size)
                if #available(iOS 11.0, *) {
                    make.top.equalTo(safeAreaLayoutGuide.snp.bottom)
                }else{
                    make.top.equalTo(snp.bottom)
                }
            }
            
            bkgView.backgroundColor = container.backgroundColor
            insertSubview(bkgView, belowSubview: container)
            let bootomSize = CGSize(width: size.width, height: size.height + UIDevice.footerSafeAreaHeight)
            bkgView.snp.makeConstraints { (make) in
                make.centerX.equalTo(snp.centerX)
                make.top.equalTo(snp.bottom)
                make.size.equalTo(bootomSize)
            }
        case .center?:
            container.snp.makeConstraints { (make) in
                make.center.equalTo(snp.center)
                make.size.equalTo(size)
            }
            
        default:
            print("top")
        }
        
        if let showClose = container.alertModel?.showClose, showClose {
            close.snp.makeConstraints { (make) in
                make.top.equalTo(container.snp.bottom).offset(20)
                make.centerX.equalTo(container)
                make.height.width.equalTo(28)
            }
        }
    }
    
    required public init?(coder aDecoder: NSCoder) { fatalError("") }
}
