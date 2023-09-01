//
//  ModeledScreen.swift
//  CoordinatorExample
//
//  Created by Dino Bartosak on 11.07.2023.
//

import UIKit
import Combine

open class ModeledScreen<ScreenModelType>: BaseScreen {

    // MARK: Dispose Bag

    public var disposeBag = Set<AnyCancellable>()

    // MARK: UIViewController

    public override func viewDidLoad() {
        super.viewDidLoad()
        bindScreenModel()
    }

    // MARK: ScreenModel Generic Property

    public private(set) var screenModel: ScreenModelType!

    // MARK: Subclass
    
    open func bindScreenModel() {}
}

// MARK: - Factory

extension ModeledScreen {
    public static func create(screenModel: ScreenModelType) -> Self {
        let vc = Self.create()
        vc.screenModel = screenModel
        return vc
    }
}

