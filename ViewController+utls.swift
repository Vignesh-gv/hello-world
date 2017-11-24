//
//  ViewController+utls.swift
//  eventTracking
//
//  Created by Vignesh on 23/11/17.
//  Copyright © 2017 ThoughtMaQers. All rights reserved.
//

import UIKit
private let swizzling: (UIViewController.Type) -> () = { viewController in
    
    let originalSelector = #selector(viewController.viewWillAppear(_:))
    let swizzledSelector = #selector(viewController.proj_viewWillAppear(animated:))
    
    let originalMethod = class_getInstanceMethod(viewController, originalSelector)
    let swizzledMethod = class_getInstanceMethod(viewController, swizzledSelector)
    
    method_exchangeImplementations(originalMethod!, swizzledMethod!) }

public extension UIViewController {
    
    static let classInit: Void = {
        // make sure this isn't a subclass
        swizzling(UIViewController.self)
    }()
    
    // MARK: - Method Swizzling
    
    @objc func proj_viewWillAppear(animated: Bool) {
        self.proj_viewWillAppear(animated: animated)
        
        let viewControllerName = NSStringFromClass(type(of: self))
        update()
        print("viewWillAppear: \(viewControllerName)")
    }
    
    func update(){
        print("update to server")
    }
}
