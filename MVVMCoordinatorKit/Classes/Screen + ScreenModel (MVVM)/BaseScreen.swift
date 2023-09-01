//
//  BaseScreen.swift
//  CoordinatorExample
//
//  Created by Dino Bartosak on 11.07.2023.
//

import UIKit

open class BaseScreen: UIViewController {

    // MARK: Deinit

    deinit {
        print("💀 BaseScreen deinit -> \(self)")
    }

    // MARK: UIViewController

    public override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    // MARK: Subclass

    open func setupUI() {}
}

// MARK: - Factory

extension BaseScreen {
    static func create() -> Self {
        return Self.loadFromNib()
    }
}

// MARK: - UIViewController + Nib

private extension UIViewController {
    static func loadFromNib() -> Self {
        return self.init(nibName: String(describing: self), bundle: nil)
    }
}
