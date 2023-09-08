//
//  Screen.swift
//  MVVMCoordinatorKit
//
//  Created by Dino Bartosak on 11.07.2023.
//

import UIKit
import Combine

open class Screen<T>: UIViewController {

    public var disposeBag = Set<AnyCancellable>()

    deinit { MVVMCoordinatorKitLogger.log("💀 Screen deinit: \(self)") }

    public private(set) var screenModel: T!

    public override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindScreenModel()
    }

    open func setupUI() {}
    open func bindScreenModel() {}
}

// MARK: - Factory

extension Screen {
    public static func create(screenModel: T) -> Self {
        let vc = Self.loadFromNib()
        vc.screenModel = screenModel
        return vc
    }
}

private extension UIViewController {
    static func loadFromNib() -> Self {
        return self.init(nibName: String(describing: self), bundle: nil)
    }
}
