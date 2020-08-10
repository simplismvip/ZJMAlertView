//
//  ViewController.swift
//  ZJMAlertView
//
//  Created by simplismvip on 03/28/2020.
//  Copyright (c) 2020 simplismvip. All rights reserved.
//

import UIKit
import ZJMAlertView
import ZJMKit
class ViewController: UIViewController {
    var sheetManager:JMAlertManager!
    var sheetItem:JMAlertModel!
    var sheet:JMAlertModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    @IBAction func showAlert(_ sender: Any) {
//        let name = JMAlertItem(title: "model.fullTitle()!", icon: nil)
//        let upload = JMAlertItem(title: "面对面传书", icon: nil)
//        let delete = JMAlertItem(title: "⁉️删除", icon: nil)
//
//        sheetItem = JMAlertModel(className: "JMAlertViewLoading")
//        sheetItem.items = [name,upload,delete]
//        sheetManager = JMAlertManager(superView: view, item: sheetItem)
//        sheetItem.sheetType = .center
//        sheetManager.update()
        
//        JMAlertManager.jmShowAnimation(nil)
//        JMAlertManager.jmShowNotify(nil)
//        JMAlertManager.jmShowSheet(nil)
        JMAlertManager.jmShowAlert(nil) { (item) in
            print(item.title as Any)
        }
    }
    
    @IBAction func Hide(_ sender: Any) {
        sheetManager.hide()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

