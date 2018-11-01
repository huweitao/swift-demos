//
//  Utils.swift
//  HSwiftTools
//
//  Created by huweitao on 2018/11/1.
//  Copyright © 2018 huweitao. All rights reserved.
//


import Foundation
import UIKit

class Utils: NSObject {
    static let shared:Utils = Utils()
    private override init() {
        super.init()
    }
}

func GGetCurrentNaviController() -> UINavigationController? {
    if let nc:UINavigationController = UIApplication.shared.delegate?.window??.rootViewController as? UINavigationController {
        return nc;
    }
    return nil;
}

func HGetMostTopViewController() -> UIViewController? {
    let keyWindow = UIApplication.shared.keyWindow
    if keyWindow == nil {
        DLLogError("Can't find key window")
        return nil
    }
    let rootViewController = keyWindow!.rootViewController
    return LoopFindTopViewController(rootViewController)
}

// thread safe
func HSafeAsyncMainThread(_ handler:VoidHandler?) {
    if handler == nil {
        return;
    }
    
    if Thread.isMainThread {
        handler?()
    }
    else {
        // get on main thread
        DispatchQueue.main.async {
            handler?()
        }
    }
}

func HSafeDelayMainThread(_ time:TimeInterval,_ handler:VoidHandler?) {
    if handler == nil {
        return;
    }
    
    var inTime = time
    
    if inTime < 0.0 {
        inTime = 1.0
    }
    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + inTime) {
        handler?()
    }
}

// MARK: - Private

private func LoopFindTopViewController(_ viewController: UIViewController? = nil) -> UIViewController? {
    let viewController = viewController ?? UIApplication.shared.keyWindow?.rootViewController
    
    if let navigationController = viewController as? UINavigationController,
        !navigationController.viewControllers.isEmpty
    {
        return LoopFindTopViewController(navigationController.viewControllers.last)
        
    } else if let tabBarController = viewController as? UITabBarController,
        let selectedController = tabBarController.selectedViewController
    {
        return LoopFindTopViewController(selectedController)
        
    } else if let presentedController = viewController?.presentedViewController {
        return LoopFindTopViewController(presentedController)
    }
    
    return viewController
}

func GPrintPropetylist(_ cls: Swift.AnyClass?) -> () {
    if cls == nil {
        return
    }
    var count: UInt32 = 0
    //获取类的属性列表,返回属性列表的数组,可选项
    let list = class_copyPropertyList(cls, &count)
    DLLogInfo("Property count:\(count)")
    //遍历数组
    for i in 0..<Int(count) {
        //根据下标获取属性
        let pty = list?[i]
        //获取属性的名称<C语言字符串>
        //转换过程:Int8 -> Byte -> Char -> C语言字符串
        let cName = property_getName(pty!)
        //转换成String的字符串
        let name = String(utf8String: cName)
        DLLogInfo(name!)
    }
    free(list) // 释放list
}
