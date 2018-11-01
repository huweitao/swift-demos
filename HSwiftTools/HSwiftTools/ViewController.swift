//
//  ViewController.swift
//  HSwiftTools
//
//  Created by huweitao on 2018/10/31.
//  Copyright © 2018 huweitao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        guard let eView:UIView = EmotionView.loadEmotionView() else {
            print("No emotion view")
            return
        }
        print("eView")
        eView.frame = UIScreen.main.bounds
        self.view.addSubview(eView)
    }


}

