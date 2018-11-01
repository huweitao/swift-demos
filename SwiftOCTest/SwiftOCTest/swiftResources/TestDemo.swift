//
//  TestDemo.swift
//  SwiftOCTest
//
//  Created by huweitao on 2018/9/5.
//  Copyright © 2018年 huweitao. All rights reserved.
//

import Foundation
import UIKit

@objc class TestKit:NSObject {
    
    static let shared:TestKit = TestKit()
    var isKit:Bool?
    
    private override init() {
        // 单例模式必须禁用构造方法
        print("[TestKit:init]")
        self.isKit = true;
        super.init()
    }
    
    class func logSwift(msg:String?) -> Bool {
        if var msg = msg {
            msg = msg + "__Copy msg"
            print(msg);
        }
        for x in 0...10 {
            print("Msg\(x) = \(msg ?? "kong")")
        }
        var dict:[AnyHashable : Any] = [1:"12ad",2:"kill","msg":"msgValue"]
        for (key, val) in dict {
            print("\(key):\(val)")
        }
        dict[1] = "change 1"
        let val = dict[1]!
        print("dict 1 is \(val)")
        var array = [String]()
        array.append("msg")
        array.append("world")
        array.append("中文")
        array.insert("English", at: array.count);
        print("array is \(array)")
        array.remove(at: array.count-1);
        print("array element is \(array.last!)")
        for val in array {
            print("\(val)")
        }
        return true;
    }
    
    func testlog() -> Void {
        print("Swift log begins:");
        Utils.testLog();
        Utils().loopLog();
        if self.isKit ?? false {
            print("Kit is on");
        }
        else {
            print("Kit is off");
        }
    }
    
    func tellMsg(outerParams params:Dictionary<AnyHashable, Any>?) -> String {
        if params != nil {
            print("Tell MSG:")
            var pars = params;
            pars!["10"] = "add"
            for (key, val) in pars! {
                print("\(key):\(val)")
            }
            return "Params is Set";
        }
        else {
            return "Empty Input";
        }
    }
    
    func dateTransfer(timeStamp:UInt) -> String? {
        return Date.timestampToDateFormat(timeStamp)
    }
    
    func prepareExtensionProp (msg:String) -> String {
        Utils.shared().desOwner = "Swift call OC Extension:"+msg
        return Utils.shared().desOwner;
    }
    
    func mutilArgs<N>(args:N...) -> Void {
        for arg in args {
            print("\(arg)");
        }
    }
    
    func callMulti() -> Void {
        self.mutilArgs(args: 4,5,6)
        self.mutilArgs(args: "Google", "Baidu", "Runoob")
    }
    
    func showEView(toShow:Bool, onView:UIView) {
        EmotionView.showEmptyView(toShow, onView: onView)
    }
}
