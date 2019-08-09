//
//  BaseNavigationController.swift
//  MusicPlayer
//
//  Created by 苏强 on 2019/3/22.
//  Copyright © 2019 black. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController {

    override func viewDidLoad() {
        
        super.viewDidLoad()
        // 设置半透明
        self.navigationBar.isTranslucent = false // 
        self.view.backgroundColor = UIColor.white
        self.navigationBar.shadowImage = UIImage.init()

    }
    
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        super.pushViewController(viewController, animated: true)

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
