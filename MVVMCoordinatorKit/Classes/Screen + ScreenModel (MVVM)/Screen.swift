//
//  Screen.swift
//  CoordinatorExample
//
//  Created by Dino Bartosak on 11.07.2023.
//

import UIKit

open class Screen: UIViewController {

    deinit { print("💀 Screen deinit: \(self)") }

    public override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    // MARK: Subclass

    open func setupUI() {}
}
