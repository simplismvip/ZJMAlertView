//
//  JMAlertTools.swift
//  Pods-ZJMAlertView_Example
//
//  Created by JunMing on 2020/3/30.
//

import UIKit

open class JMAlertTools: UIView {

}

extension UIImage {
    open class func imageNamed(bundleName name:String) -> UIImage? {
        func findBundle(_ bundleName:String,_ podName:String) -> Bundle? {
            if var bundleUrl = Bundle.main.url(forResource: "Frameworks", withExtension: nil) {
                bundleUrl = bundleUrl.appendingPathComponent(podName)
                bundleUrl = bundleUrl.appendingPathExtension("framework")
                if let bundle = Bundle(url: bundleUrl),let url = bundle.url(forResource: bundleName, withExtension: "bundle") {
                    return Bundle(url: url)
                }
                return nil
            }
            return nil
        }
                
        if let bundle = findBundle("JMAlert", "ZJMAlertView") {
            let scare = UIScreen.main.scale
            let imaName = String(format: "%@@%dx.png", name, Int(scare))
            if let imagePath = bundle.path(forResource: imaName, ofType: nil) {
                return UIImage(contentsOfFile: imagePath)
            }
            return nil
        }
        return nil
    }
}
