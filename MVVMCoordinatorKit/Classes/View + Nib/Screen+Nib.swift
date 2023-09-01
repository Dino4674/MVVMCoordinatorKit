//
//  Screen+Nib.swift
//  MVVMCoordinatorKit
//
//  Created by Dino Bartosak on 01.09.2023.
//

import UIKit

extension Screen {
    static func create() -> Self {
        return Self.loadFromNib()
    }
}

private extension UIViewController {
    static func loadFromNib() -> Self {
        return self.init(nibName: String(describing: self), bundle: nil)
    }
}
