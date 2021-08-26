//
//  LoginViewController.swift
//  PandaLearning
//
//  Created by yangjucai on 2021/8/26.
//

import UIKit
import SafariServices
import SwiftyJSON

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    @IBOutlet weak var email: UITextField!
    
    
    
    @IBOutlet weak var password: UITextField!
    
    
    @IBAction func LoginPressed(_ sender: UIButton) {
//        let loginVC = LoginController()
//        present(loginVC, animated: true, completion: nil)
       sendLoginRequest()
       
    }
    
    @objc func sendLoginRequest() {
        let username = email.text!   //获取用户名
        let password = password.text!    //获取密码
        
        let urlString:String = "http://1.117.107.95:8000/login/" // 请求地址
                let requestUrl = URL.init(string:urlString)
                var urlRequest = URLRequest.init(url: requestUrl!)
                urlRequest.httpMethod = "POST"
                let configuration:URLSessionConfiguration = URLSessionConfiguration.default
                let manager = URLSession(configuration: configuration)
                        // 设置表单分隔符
                let boundary = "Boundary-\(UUID().uuidString)"
                urlRequest.setValue("multipart/form-data; boundary=\(boundary)",
                    forHTTPHeaderField:"Content-Type")
                var bodyData = Data()
        let paramers = ["email": username, "password": password ]
                for(key, value) in paramers {
                    // 数据之前要用 --分隔线 来隔开 ，否则后台会解析失败
                    bodyData.append("--\(boundary)\r\n".data(using:String.Encoding.utf8)!)
                    bodyData.append("--\(boundary)\r\n".data(using:String.Encoding.utf8)!)
                    bodyData.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n".data(using: String.Encoding.utf8)!)
                    bodyData.append("\(value)\r\n".data(using:String.Encoding.utf8)!)
                }
                // --分隔线-- 为整个表单的结束符
                bodyData.append("--\(boundary)--\r\n".data(using:String.Encoding.utf8)!)
                urlRequest.httpBody = bodyData
//                LRLog(message:"Request URL \(_URLStr) paramers:\(paramers!)")
                let task = manager.dataTask(with: urlRequest){(data,response,error)in
                    if let e = error {
                        print(e)
                        return
                    }
                    
                    guard let msg = String(data: data!, encoding: .utf8) else {
                        print("Unable to parse data string.")
                        return
                    }
    
                    if(msg == "登陆成功" ){
                        DispatchQueue.main.async {
        
                            let mainBoard:UIStoryboard! = UIStoryboard(name: "Main", bundle: nil)
                            let VCMain = mainBoard!.instantiateViewController(identifier: "vcMain")
                            UIApplication.shared.windows[0].rootViewController = VCMain
                        }
                    } else {
                        DispatchQueue.main.async {
                            // If user can't login, display the error message from the server.
                            let alert = UIAlertController(title: "Login Error", message: msg, preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
                            self.present(alert, animated: true, completion: nil)
                        }
                    }
                }
                task.resume()
        
    }
    
    @IBAction func RegisterPressed(_ sender: UIButton) {
        let safariVC = SFSafariViewController(url: URL(string: "http://110.40.185.37/M_signup")!)
        present(safariVC, animated: true, completion: nil)
    }
    

}
