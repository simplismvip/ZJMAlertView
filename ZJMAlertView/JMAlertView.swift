//
//  JMAlertView.swift
//  Pods-ZJMAlertView_Example
//
//  Created by JunMing on 2020/4/1.
//

import UIKit

class JMAlertViewLoading: UIView, JMAlertCompProtocol {
    var alertModel: JMAlertModel?
    private let backView = UIView()
    private let topLayer = CAShapeLayer()
    private let bottomLayer = CAShapeLayer()
    private let leftLayer = CAShapeLayer()
    private let rightLayer = CAShapeLayer()
    private var h_height: CGFloat = 60.0
    private var r_radius: CGFloat = 60.0/7
    private var translatLen: CGFloat = 60.0/7
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(backView)
        backView.layer.addSublayer(topLayer)
        backView.layer.addSublayer(leftLayer)
        backView.layer.addSublayer(bottomLayer)
        backView.layer.addSublayer(rightLayer)
        
        backgroundColor = UIColor.groupTableViewBackground
        layer.cornerRadius = 10
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backView.frame = CGRect.Rect(20, 20, jmWidth-40, jmHeight-40)
        
        h_height = backView.jmWidth
        r_radius = h_height/7
        translatLen = h_height/7
        
        setupSubLayers()
        startAnimation()
    }
    
    private func setupSubLayers() {
        
        let centerLine = h_height/2
        let radius = r_radius
        
        let topPoint = CGPoint(x: centerLine, y: radius)
        configLayer(topPoint, UIColor.jmRGB(90, 200, 200), topLayer)
        
        let leftPoint = CGPoint(x: radius, y: centerLine)
        configLayer(leftPoint, UIColor.jmRGB(250, 85, 78), leftLayer)
        
        let bottomPoint = CGPoint(x: centerLine, y: h_height - radius)
        configLayer(bottomPoint, UIColor.jmRGB(92, 201, 105), bottomLayer)
        
        let rightPoint = CGPoint(x: h_height - radius, y: centerLine)
        configLayer(rightPoint, UIColor.jmRGB(253, 175, 75), rightLayer)
    }
    
    func startAnimation() {
        addTranslationAniToLayer(topLayer, x: 0, y: translatLen)
        addTranslationAniToLayer(leftLayer, x: translatLen, y: 0)
        addTranslationAniToLayer(bottomLayer, x: 0, y: -translatLen)
        addTranslationAniToLayer(rightLayer, x: -translatLen, y: 0)
        addRotationAniToLayer(backView.layer)
    }
    
    private func configLayer(_ center:CGPoint,_ color: UIColor,_ layer:CAShapeLayer) {
        layer.opacity = 1.0;
        layer.fillColor = color.cgColor;
        layer.frame = CGRect(x: center.x - r_radius, y: center.y - r_radius, width: r_radius * 2, height: r_radius * 2)
        let bezier = UIBezierPath(arcCenter: CGPoint(x: r_radius, y: r_radius), radius: r_radius, startAngle: 0, endAngle: CGFloat(.pi * 2.0), clockwise: true)
        layer.path = bezier.cgPath
    }
    
    private func addTranslationAniToLayer(_ layer:CALayer,x:CGFloat,y:CGFloat) {
        let animation = CAKeyframeAnimation(keyPath: "transform")
        animation.duration = 1.3;
        animation.repeatCount = HUGE;
        animation.isRemovedOnCompletion = false;
        let fromValue = NSValue(caTransform3D: CATransform3DMakeTranslation(0, 0, 0))
        let toValue = NSValue(caTransform3D: CATransform3DMakeTranslation(x, y, 0))
        animation.values = [fromValue, toValue, fromValue, toValue, fromValue];
        layer.add(animation, forKey: "translationKeyframeAni")
    }
    
    private func addRotationAniToLayer(_ layer:CALayer) {
        let animation = CABasicAnimation(keyPath: "transform.rotation.z")
        animation.fromValue = 0
        animation.toValue = CGFloat(.pi * 2.0)
        animation.duration = 1.3;
        animation.repeatCount = HUGE;
        animation.isRemovedOnCompletion = false
        layer.add(animation, forKey: "rotationAni")
    }
    
    func updateView() -> CGSize {
        return CGSize(width: 100, height: 100)
    }
    
    func remove(_ backView:JMAlertBackView) {
        UIView.animate(withDuration: 0.5, animations: {
            self.alpha = 0.0
        }) { (finished) in
            self.topLayer.removeAllAnimations()
            self.leftLayer.removeAllAnimations()
            self.bottomLayer.removeAllAnimations()
            self.rightLayer.removeAllAnimations()
            self.backView.layer.removeAllAnimations()
            backView.removeFromSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError("⚠️") }
}

class JMAlertInfoView: UIView, JMAlertCompProtocol {
    private var title = UILabel(frame: CGRect.zero)
    private var subTitle = UILabel(frame: CGRect.zero)
    private var leftBtn = UIButton(type: .system)
    private var rightBtn = UIButton(type: .system)
    private var spLine = UIView(frame: CGRect.zero)
    
    var alertModel: JMAlertModel? {
        willSet {
            title.text = newValue?.title
            subTitle.text = newValue?.subTitle
            guard let tempItems = newValue!.items else { return }
            if tempItems.count == 2 {
                if let leftItem = tempItems.first {
                    leftBtn.setTitle(leftItem.title, for: .normal)
                    leftBtn.setBackgroundImage(leftItem.icon, for: .normal)
                    leftBtn.tag = 100
                }
                if let rightItem = tempItems.last {
                    rightBtn.setTitle(rightItem.title, for: .normal)
                    rightBtn.setBackgroundImage(rightItem.icon, for: .normal)
                    rightBtn.tag = 101
                }
            }else {
                if let leftItem = tempItems.first {
                    leftBtn.setTitle(leftItem.title, for: .normal)
                    leftBtn.setBackgroundImage(leftItem.icon, for: .normal)
                    leftBtn.tag = 100
                }
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 15
        layer.masksToBounds = true
        
        backgroundColor = UIColor.jmRGB(240, 240, 240)
        addSubview(title)
        addSubview(subTitle)
        addSubview(leftBtn)
        addSubview(rightBtn)
        addSubview(spLine)
        
        configSubView()
        leftBtn.addTarget(self, action: #selector(touchAction(_:)), for: UIControl.Event.touchUpInside)
        rightBtn.addTarget(self, action: #selector(touchAction(_:)), for: UIControl.Event.touchUpInside)
    }
    
    @objc func touchAction(_ sender:UIButton) {
        remove(self.superview as! JMAlertBackView)
        if let items = alertModel!.items {
            let item = items[sender.tag - 100]
            if let eventName = item.eventName {
                jmRouterEvent(eventName: eventName, info: item)
            }
            
            if let action = item.action {
                action(item)
            }
        }
    }
    
    func updateView() -> CGSize{
        title.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(10)
            make.height.equalTo(30)
            make.centerX.equalTo(self.snp.centerX)
        }
        
        if alertModel?.items?.count == 2 {
            leftBtn.snp.makeConstraints { (make) in
                make.right.equalTo(self.snp.centerX).offset(-10)
                make.bottom.equalTo(snp.bottom).offset(-10)
                make.width.equalTo(100)
                make.height.equalTo(30)
            }
            
            rightBtn.snp.makeConstraints { (make) in
                make.left.equalTo(self.snp.centerX).offset(10)
                make.bottom.equalTo(snp.bottom).offset(-10)
                make.width.equalTo(100)
                make.height.equalTo(30)
            }
        }else {
            leftBtn.snp.makeConstraints { (make) in
                make.centerX.equalTo(self.snp.centerX)
                make.bottom.equalTo(snp.bottom).offset(-10)
                make.width.equalTo(100)
                make.height.equalTo(30)
            }
        }
        
        spLine.snp.makeConstraints { (make) in
            make.height.equalTo(1)
            make.width.equalTo(self)
            make.bottom.equalTo(leftBtn.snp.top).offset(-10)
        }
        
        subTitle.snp.makeConstraints { (make) in
            make.left.equalTo(snp.left).offset(20)
            make.right.equalTo(snp.right).offset(-20)
            make.top.equalTo(title.snp.bottom).offset(5)
            make.bottom.equalTo(spLine.snp.top).offset(-10)
        }
        
        return CGSize(width: 290, height: 180)
    }
    
    func configSubView() {
        title.font = UIFont.jmMedium(20)
        title.textAlignment = .center
        title.textColor = UIColor.jmRGB(31, 31, 31)
        
        subTitle.font = UIFont.jmRegular(17)
        subTitle.textAlignment = .center
        subTitle.textColor = UIColor.jmRGB(98,98,98)
        subTitle.numberOfLines = 0
        
        let frame = CGRect.Rect(0, 0, 60, 30)
        let colors = [UIColor.jmHexColor("#EE9A49"),UIColor.jmHexColor("#EE4000")]
        leftBtn.layer.cornerRadius = 15
        leftBtn.tintColor = UIColor.white
        leftBtn.backgroundColor = UIColor.jmGradientColor(.leftToBottom, colors, frame)
        
        rightBtn.layer.cornerRadius = 15
        rightBtn.tintColor = UIColor.white
        rightBtn.backgroundColor = leftBtn.backgroundColor
        
        spLine.backgroundColor = UIColor.jmRGB(211, 211, 211)
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError("") }
}
