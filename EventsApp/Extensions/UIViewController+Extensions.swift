//
//  UIViewController+Extensions.swift
//  EventsApp
//
//  Created by icedoutxcv on 06/10/2020.
//

import Foundation
import UIKit

extension UIViewController {
    static func instiantiate<T>() -> T {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let controller = storyboard.instantiateViewController(identifier: "\(T.self)") as! T
        return controller
    }
}
