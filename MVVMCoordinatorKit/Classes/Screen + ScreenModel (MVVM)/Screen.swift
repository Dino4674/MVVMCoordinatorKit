//
//  Screen.swift
//  MVVMCoordinatorKit
//
//  Created by Dino Bartosak on 11.07.2023.
//

import UIKit

open class Screen: UIViewController {

    deinit { MVVMCoordinatorKitLogger.log("💀 Screen deinit: \(self)") }

    public override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    // MARK: Subclass

    open func setupUI() {}
}
