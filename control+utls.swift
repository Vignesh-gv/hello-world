//
//  control+utls.swift
//  eventTracking
//
//  Created by Vignesh on 23/11/17.
//  Copyright © 2017 ThoughtMaQers. All rights reserved.
//

import UIKit

private let swizzling: (AnyClass, Selector, Selector) -> () = { forClass, originalSelector, swizzledSelector in
    let originalMethod = class_getInstanceMethod(forClass, originalSelector)
    let swizzledMethod = class_getInstanceMethod(forClass, swizzledSelector)
    method_exchangeImplementations(originalMethod!, swizzledMethod!)
}

public extension UIControl {
    
    static let classCInit: Void = {
        let originalSelector = #selector(sendAction(_:to:for:))
        let swizzledSelector = #selector(swizzled_sendAction(_:to:for:))
        swizzling(UIControl.self, originalSelector, swizzledSelector)
    }()
    
    @objc func swizzled_sendAction(_ action: Selector, to target: Any?, for event: UIEvent?) {
        swizzled_sendAction(action, to: target, for: event)
        print("Method was triggered: \(action)")
    }
    
}
