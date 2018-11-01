//
//  EmotionView.swift
//  GCash
//
//  Created by huweitao on 2018/10/30.
//  Copyright © 2018 GXI. All rights reserved.
//

import Foundation
import UIKit

var motionV:UIView?

class EmotionView: UIView {
    
    class func loadFromNib() -> EmotionView {
        return Bundle.main.loadNibNamed("EmotionView", owner: self, options: nil)?[0] as! EmotionView
    }
    
    class func createMView() {
        motionV = EmotionView.loadFromNib()
        motionV?.frame = UIScreen.main.bounds
    }
    
    class func showEmptyView(_ toShow:Bool, onView:UIView?) {
        guard let parentView = onView else {
            return
        }
        if motionV == nil {
            createMView()
        }
        if toShow {
            motionV!.isHidden = false
            parentView.addSubview(motionV!)
        }
        else {
            motionV!.isHidden = true
            motionV!.removeFromSuperview()
        }
        
    }
}
