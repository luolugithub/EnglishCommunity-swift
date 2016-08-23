//
//  JFRegisterViewController.swift
//  BaoKanIOS
//
//  Created by zhoujianfeng on 16/5/13.
//  Copyright © 2016年 六阿哥. All rights reserved.
//

import UIKit

protocol JFRegisterViewControllerDelegate {
    func registerSuccess(username: String, password: String)
}

class JFRegisterViewController: UIViewController {
    
    @IBOutlet weak var bgImageView: UIImageView!
    
    @IBOutlet weak var usernameView: UIView!
    @IBOutlet weak var usernameField: UITextField!
    
    @IBOutlet weak var passwordView1: UIView!
    @IBOutlet weak var passwordField1: UITextField!
    
    @IBOutlet weak var passwordView2: UIView!
    @IBOutlet weak var passwordField2: UITextField!
    
    @IBOutlet weak var registerButton: UIButton!
    
    var delegate: JFRegisterViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let effectView = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffectStyle.Dark))
        effectView.frame = SCREEN_BOUNDS
        bgImageView.addSubview(effectView)
        
        didChangeTextField(usernameField)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        view.endEditing(true)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.LightContent
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    @IBAction func didChangeTextField(sender: UITextField) {
        if usernameField.text?.characters.count >= 5 && passwordField1.text?.characters.count > 5 && passwordField2.text?.characters.count > 5 {
            registerButton.enabled = true
            registerButton.backgroundColor = COLOR_NAV_BG
        } else {
            registerButton.enabled = false
            registerButton.backgroundColor = UIColor.grayColor()
        }
    }
    
    @IBAction func didTappedBackButton() {
        view.endEditing(true)
        navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func didTappedLoginButton(sender: UIButton) {
        
        view.endEditing(true)
        
        if passwordField1.text != passwordField2.text {
            JFProgressHUD.showInfoWithStatus("两次输入的密码不一致")
            return
        }
        
        JFProgressHUD.showWithStatus("正在注册")
        JFAccountModel.normalAccountRegister("username", username: usernameField.text!, password: passwordField1.text!) { (success, tip) in
            if (success) {
                JFProgressHUD.dismiss()
                self.didTappedBackButton()
                self.delegate?.registerSuccess(self.usernameField.text!, password: self.passwordField1.text!)
            } else {
                JFProgressHUD.showInfoWithStatus(tip)
            }
        }
        
    }
    
}