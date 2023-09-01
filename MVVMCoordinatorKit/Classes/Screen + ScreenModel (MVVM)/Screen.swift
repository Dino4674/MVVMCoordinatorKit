//
//  Screen.swift
//  CoordinatorExample
//
//  Created by Dino Bartosak on 11.07.2023.
//

import UIKit

open class Screen: UIViewController {

    // MARK: Deinit

    deinit {
        print("💀 Screen deinit -> \(self)")
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

extension Screen {
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
