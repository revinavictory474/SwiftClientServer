//
//  ViewController.swift
//  someNewProject
//
//  Created by Юрий Султанов on 17.05.2021.
//

import UIKit

class MainViewController: UIViewController {
    let mySingleton = MySingleton.instance
//    let mySingletonPlus = MySingleton()
    private let notifactionName = Notification.Name(NotificationNames.someNotification.rawValue)
    
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var userSurnameTextField: UITextField!
    @IBAction func saveButtonAction(_ sender: Any) {
        mySingleton.userName = userNameTextField.text ?? ""
        mySingleton.userSurname = userSurnameTextField.text ?? ""
    }
    @IBAction func goToSecondAction(_ sender: Any) {
        guard let secondVC = UIStoryboard(name: "Main", bundle: nil)
                .instantiateViewController(identifier: "SecondViewController")
                as? SecondViewController else { return }
        secondVC.delegate = self
        
        present(secondVC,
                animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userSurnameTextField.delegate = self
        
        NotificationCenter
            .default
            .addObserver(
                self,
                selector: #selector(notificationRecive(notification:)),
                name: notifactionName,
                object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(
            self,
            name: notifactionName,
            object: nil)
    }

    
    @objc private func notificationRecive(notification: Notification) {
        self.view.backgroundColor = notification.userInfo?["color"] as? UIColor
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        userNameTextField.text = mySingleton.userName
        userSurnameTextField.text = mySingleton.userSurname
    }
    
    
}

extension MainViewController: MyNewDelegate {
    func didPressButton() {
        mySingleton.userName = ""
        mySingleton.userSurname = ""
    }
}

extension MainViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("StartEditing")
    }
}

