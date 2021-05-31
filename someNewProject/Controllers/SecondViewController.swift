//
//  SecondViewController.swift
//  someNewProject
//
//  Created by Юрий Султанов on 17.05.2021.
//

import UIKit

class SecondViewController: UIViewController {
    weak var delegate: MyNewDelegate?
    
    private let notifactionName = Notification.Name(NotificationNames.someNotification.rawValue)
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var usersurnameLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter
            .default
            .addObserver(
                self,
                selector: #selector(notificationRecive(notification:)),
                name: notifactionName,
                object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc private func notificationRecive(notification: Notification) {
        self.view.backgroundColor = notification.userInfo?["color"] as? UIColor
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        usernameLabel.text = MySingleton.instance.userName
        usersurnameLabel.text = MySingleton.instance.userSurname
    }
}
