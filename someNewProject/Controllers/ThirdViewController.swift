//
//  ThirdViewController.swift
//  someNewProject
//
//  Created by Юрий Султанов on 17.05.2021.
//

import UIKit

class ThirdViewController: UIViewController {
    @IBAction func sendNoticationAction(_ sender: Any) {
        let notifactionName = Notification.Name(NotificationNames.someNotification.rawValue)
        
        NotificationCenter.default.post(name: notifactionName,
                                        object: nil,
                                        userInfo: ["color" : UIColor(
                                                    red: CGFloat.random(in: 0...255)/255,
                                                    green: CGFloat.random(in: 0...255)/255,
                                                    blue: CGFloat.random(in: 0...255)/255,
                                                    alpha: 1.0)])
    }
    
    @IBAction func closeAction(_ sender: Any) {
        dismiss(animated: true)
    }
}
