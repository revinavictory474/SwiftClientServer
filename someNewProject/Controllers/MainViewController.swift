//
//  ViewController.swift
//  someNewProject
//
//  Created by Юрий Султанов on 17.05.2021.
//

import UIKit
import WebKit
import Alamofire

class MainViewController: UIViewController {
    let mySingleton = MySingleton.instance
    private let notifactionName = Notification.Name(NotificationNames.someNotification.rawValue)
    
  @IBOutlet weak var webview: WKWebView! {
    didSet{
      webview.navigationDelegate = self
    }
  }
    
  override func viewDidLoad() {
      super.viewDidLoad()
      var urlComponents = URLComponents()
      urlComponents.scheme = "https"
      urlComponents.host = "oauth.vk.com"
      urlComponents.path = "/authorize"
      urlComponents.queryItems = [
        URLQueryItem(name: "client_id", value: "7868515"),
        URLQueryItem(name: "display", value: "mobile"),
        URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
        URLQueryItem(name: "scope", value: "262150"),
        URLQueryItem(name: "response_type", value: "token"),
        URLQueryItem(name: "v", value: "5.68")
      ]
    let request = URLRequest(url: urlComponents.url!)
    webview.load(request)
    
  }

  override func viewDidAppear(_ animated: Bool) {
      super.viewDidAppear(animated)
  }
}

extension MainViewController:WKNavigationDelegate {
  func webView(_ webView: WKWebView,
               decidePolicyFor navigationResponse: WKNavigationResponse,
               decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
                  guard let url = navigationResponse.response.url, url.path == "/blank.html", let fragment = url.fragment  else {            decisionHandler(.allow)
                  return
              }
    let params = fragment
      .components(separatedBy: "&")
      .map { $0.components(separatedBy: "=") }
      .reduce([String: String]()) { result, param in
        var dict = result
        let key = param[0]
        let value = param[1]
        dict[key] = value
        return dict
      }
    Session.instance.token = params["access_token"] ?? ""
    print("Token is \(Session.instance.token)")
    
    var parameters: Parameters = [
      "access_token": Session.instance.token,
      "v": "5.68"
    ]
    Makerequest(apiMethod: "apps.getFriendsList", parameters: parameters)
    
    parameters = [
      "access_token": Session.instance.token,
      "v": "5.68",
      "owner_id": "170575832"
    ]
    Makerequest(apiMethod: "photos.getAll", parameters: parameters)
    
    parameters = [
      "access_token": Session.instance.token,
      "v": "5.68",
      "user_id": "170575832"
    ]
    Makerequest(apiMethod: "groups.get", parameters: parameters)
    
    parameters = [
      "access_token": Session.instance.token,
      "v": "5.68",
      "q": "Swift"
    ]
    Makerequest(apiMethod: "groups.search", parameters: parameters)
      
    decisionHandler(.cancel)
  }
  
  func Makerequest(apiMethod: String, parameters: Parameters) {
    AF.request("https://api.vk.com/method/" + apiMethod, method: .get, parameters: parameters)
      .responseJSON { response in print("\(apiMethod) is \(response.value)") }
  }
}
