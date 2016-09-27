//
//  ViewController.swift
//  CaptchaView
//
//  Created by Cheer on 16/9/27.
//  Copyright © 2016年 joekoe. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view.addSubview(CaptchaView(frame: CGRect(origin: view.center, size: CGSizeMake(60, 35))))
    }


}

