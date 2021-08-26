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
        
        let username = email.text!   //获取用户名
        let password = password.text!    //获取密码
       


        let credentials = JSON(dictionaryLiteral: ("email",username),("password", password))

        /// Connect to localhost through an URLSession
//        var loginRequest = URLRequest(url: URL(string: "http://192.168.50.19/login.php")!)
        var loginRequest = URLRequest(url: URL(string: "http://1.117.107.95:8000/login/")!)
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
    
    @IBAction func RegisterPressed(_ sender: UIButton) {
        let safariVC = SFSafariViewController(url: URL(string: "http://110.40.185.37/")!)
        present(safariVC, animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
