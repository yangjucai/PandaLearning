//
//  UserLogin.swift
//  PandaLearning
//
//  Created by yangjucai on 2021/8/26.
//

import UIKit
import SwiftyJSON

class LoginController: UIViewController {

    var txtUser:UITextField!   //用户名输入框
    var txtPwd:UITextField!    //密码输入框
    var btnLogin:UIButton!     //确认登录按钮
    
    //界面登陆时加载的函数
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //获取屏幕尺寸
        let mainSize = UIScreen.main.bounds.size
        
        //登录框背景
        let vLogin = UIView(frame: CGRect(x: 30, y: 200, width: mainSize.width-30, height: 250))
        vLogin.layer.borderWidth = 0.5  //边框宽度
        vLogin.layer.borderColor = UIColor.lightGray.cgColor   //边框颜色
        vLogin.backgroundColor = UIColor.white  //背景颜色
        self.view.addSubview(vLogin)   //把登录框界面添加到当前界面
        
        
        //用户名输入框
        txtUser = UITextField(frame: CGRect(x: 30, y: 30, width: vLogin.frame.width-60, height: 44))
        txtUser.layer.cornerRadius = 5          //边角弧度
        txtUser.layer.borderColor = UIColor.lightGray.cgColor
        txtUser.layer.borderWidth = 0.5
        txtUser.becomeFirstResponder()
        txtUser.autocapitalizationType = .none  //是否自动大写，这里否
        txtUser.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 44, height: 44)) //用户名输入框左边的视图（待会要添加一个图标）
        txtUser.leftViewMode = UITextField.ViewMode.always   //图标是否要一直显示
        
        //用户名输入框左侧图标
        let imgUser = UIImageView(frame: CGRect(x: 11, y: 11, width: 22, height: 22))
        imgUser.image = UIImage(named: "iconfont-user")  //设置图片
        txtUser.leftView!.addSubview(imgUser)   //把图标添加到用户名输入框的左侧
        vLogin.addSubview(txtUser)   //把用户名输入框添加到弹出窗口的界面中
        
        //密码输入框
        txtPwd = UITextField(frame: CGRect(x: 30, y: 90, width: vLogin.frame.size.width-60, height: 44))
        txtPwd.layer.cornerRadius = 5
        txtPwd.layer.borderColor = UIColor.lightGray.cgColor
        txtPwd.layer.borderWidth = 0.5
        txtPwd.isSecureTextEntry = true   //输入的时候不显示具体字符，用 * 代替
        txtPwd.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        txtPwd.leftViewMode = UITextField.ViewMode.always
        
        //密码输入框左侧图标
        let imgPwd = UIImageView(frame: CGRect(x: 11, y: 11, width: 22, height: 22))
        imgPwd.image = UIImage(named: "iconfont-password")
        txtPwd.leftView!.addSubview(imgPwd)
        vLogin.addSubview(txtPwd)
        
        
        //登录确认按钮
        btnLogin = UIButton(frame: CGRect(x: mainSize.width/2-120/2, y: 150, width: 120, height: 50))
        btnLogin.setTitle("登录", for: .normal)//按钮名称
        btnLogin.backgroundColor = UIColor.green  //按钮背景颜色
        vLogin.addSubview(btnLogin)
        
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            print("将要按下Return按钮，返回值是是否结束输入（是否失去焦点）")
            textField.resignFirstResponder()
            return true
        }
        
        
        //当按钮点击时就触发 loginEvent 函数执行
        btnLogin.addTarget(self, action: #selector(sendLoginRequest), for: .touchUpInside)
        
    }
            


    @objc func sendLoginRequest() {
        let username = txtUser.text!   //获取用户名
        let password = txtPwd.text!    //获取密码
       


        let credentials = JSON(dictionaryLiteral: ("username",username),("password", password))

        /// Connect to localhost through an URLSession
        var loginRequest = URLRequest(url: URL(string: "http://192.168.50.19/login.php")!)
        loginRequest.httpMethod = "POST"
        loginRequest.httpBody = credentials.description.data(using: .utf8)

        let task = URLSession.shared.dataTask(with: loginRequest) { (data, response, error) in
            if let e = error {
                print(e)
                return
            }

            do {
                let raw = try JSON(data: data!)
                print(raw)
                DispatchQueue.main.async {
//                    self.homeViewController?.loginButton.setTitle("Log out", for: .normal)
//                    self.homeViewController?.loginButton.tintColor = redTint
//                    self.homeViewController?.loginButton.layer.borderColor = redTint.cgColor
//                    self.dismissView()
                    let mainBoard:UIStoryboard! = UIStoryboard(name: "Main", bundle: nil)
                    let VCMain = mainBoard!.instantiateViewController(identifier: "vcMain")
                    UIApplication.shared.windows[0].rootViewController = VCMain
                }

                print("login success")
//                let mainBoard:UIStoryboard! = UIStoryboard(name: "Main", bundle: nil)
//                let VCMain = mainBoard!.instantiateViewController(identifier: "vcMain")
//                UIApplication.shared.windows[0].rootViewController = VCMain


            } catch {
                guard let msg = String(data: data!, encoding: .utf8) else {
                    print("Unable to parse data string.")
                    return
                }
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


}

