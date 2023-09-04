//
//  UIViewController+Presentable.swift
//  MVVMCoordinatorKit
//
//  Created by Dino Bartosak on 29.08.2023.
//

import UIKit

extension UIViewController: Presentable {
    public func toPresentable() -> UIViewController {
        return self
    }
}
