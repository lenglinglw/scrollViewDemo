//
//  olginViewController.swift
//  MusicPlayer
//
//  Created by 苏强 on 2019/8/9.
//  Copyright © 2019 black. All rights reserved.
//

import UIKit
import SnapKit
class LoginViewController: BaseViewController {
    
    let phoneTextField: UITextField = UITextField.init()
    let spaceViewTwo = UIView.init()
    let pswTextFiled: UITextField = UITextField.init()
    let btn: UIButton = UIButton.init(type: .custom)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUi()
    }
    
    override func viewWillAppear(_ animated: Bool) {
    
        pswTextFiled.text = ""
        showLabText()
    }
    
    private func setUi() {
        view.backgroundColor = #colorLiteral(red: 0.9529411765, green: 0.9529411765, blue: 0.9529411765, alpha: 1)
        
        phoneTextField.placeholder = "请输入手机号"
        phoneTextField.keyboardType = .phonePad
        phoneTextField.textAlignment = .center
        view.addSubview(phoneTextField)
        phoneTextField.snp.makeConstraints { (m) in
            m.centerX.equalToSuperview()
            m.top.equalToSuperview().offset(50)
            m.left.equalToSuperview().offset(20)
            m.height.equalTo(45)
        }
        
        spaceViewTwo.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        view.addSubview(spaceViewTwo)
        spaceViewTwo.snp.makeConstraints { (m) in
            m.bottom.equalTo(phoneTextField.snp_bottom)
            m.left.equalToSuperview().offset(20)
            m.right.equalToSuperview().offset(20)
            m.height.equalTo(1)
        }
        
        pswTextFiled.placeholder = "请设置密码"
        pswTextFiled.isSecureTextEntry = true
        pswTextFiled.textAlignment = .center
        view.addSubview(pswTextFiled)
        pswTextFiled.snp.makeConstraints { (m) in
            m.centerX.equalToSuperview()
            m.top.equalTo(phoneTextField.snp_bottom).offset(20)
            m.left.equalToSuperview().offset(20)
            m.height.equalTo(45)
        }
        
        let spaceView = UIView.init()
        spaceView.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        view.addSubview(spaceView)
        spaceView.snp.makeConstraints { (m) in
            m.bottom.equalTo(pswTextFiled.snp_bottom)
            m.left.equalToSuperview().offset(20)
            m.right.equalToSuperview().offset(20)
            m.height.equalTo(1)
        }
        
        btn.setTitle("确定", for: .normal)
        btn.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        btn.addTarget(self, action: #selector(btnClick), for: .touchUpInside)
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = 5
        view.addSubview(btn)
        btn.snp.makeConstraints { (m) in
            m.centerX.equalToSuperview()
            m.top.equalTo(pswTextFiled.snp_bottom).offset(40)
            m.left.equalToSuperview().offset(20)
            m.height.equalTo(50)
        }
    }
    
    private func showLabText() {
        
        if LocalDataStorage.getNormalData(key: "login") == nil {
            pswTextFiled.placeholder = "请设置密码"
            self.title = "设置密码"
            phoneTextField.isHidden = false
            spaceViewTwo.isHidden   = false
        } else {
            pswTextFiled.placeholder = "请输入密码"
            self.title = "输入密码"
            phoneTextField.isHidden = true
            spaceViewTwo.isHidden   = true
            navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "重置密码", style: .plain, target: self, action: Selector.init(("rightBarButtonClick")))
        }
    }
    
    @objc func btnClick() {
        
        if phoneTextField.isHidden == true {
            
        } else {
            guard phoneTextField.text?.count == 11 else {
                CBToast.showToastAction(message: "请输入正确手机号")
                return
            }
            LocalDataStorage.storageDataAndKey(data: phoneTextField.text, key: "phone")
        }
        
        guard pswTextFiled.text?.count != 0 else {
            CBToast.showToastAction(message: "密码不能为空")
            return
        }
        if LocalDataStorage.getNormalData(key: "login") == nil {
            LocalDataStorage.storageDataAndKey(data: pswTextFiled.text, key: "login")
        } else {
            guard pswTextFiled.text == (LocalDataStorage.getNormalData(key: "login") as! String) else {
                CBToast.showToastAction(message: "请输入正确的密码")
                return
            }
        }
        print("跳转到地图页面")
        navigationController?.pushViewController(MapViewController.init(), animated: true)
        
    }
    
    @objc func rightBarButtonClick() {
        
        print("重置密码")
        
        let alert = UIAlertController(title: "重置密码", message: "", preferredStyle: .alert)
        
        alert.addTextField(configurationHandler: { (textField: UITextField!) -> Void in
            textField.placeholder = "请输入手机号"
            // 添加监听代码，监听文本框变化时要做的操作
            NotificationCenter.default.addObserver(self, selector: #selector(self.alertTextFieldDidChange), name: UITextField.textDidChangeNotification, object: textField)
        })
        
        let againAction = UIAlertAction(title: "确定", style: .default, handler: { [weak self] action in
            guard let self = self else {
                return
            }
            LocalDataStorage.removeNormalData(key: "phone")
            LocalDataStorage.removeNormalData(key: "login")
            self.showLabText()
        })
        againAction.isEnabled = false
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        alert.addAction(againAction)
        self.present(alert, animated: true, completion: nil)
        
    }

    @objc func alertTextFieldDidChange(){
        let alertController = self.presentedViewController as! UIAlertController?
        if (alertController != nil) {
            let login = (alertController!.textFields?.first)! as UITextField
            let okAction = alertController!.actions.last! as UIAlertAction
            if (login.text == (LocalDataStorage.getNormalData(key: "phone") as! String)) {
                okAction.isEnabled = true
            } else {
                okAction.isEnabled = false
            }
        }
    }

}


