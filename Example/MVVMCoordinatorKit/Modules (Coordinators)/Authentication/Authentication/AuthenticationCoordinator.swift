//
//  AuthenticationCoordinator.swift
//  MVVMCoordinatorKit_Example
//
//  Created by Dino Bartosak on 05.09.2023.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import MVVMCoordinatorKit
import Combine

enum AuthenticationCoordinatorResult {
    case didAuthenticate
}

class AuthenticationCoordinator: Coordinator<DeepLinkOption, AuthenticationCoordinatorResult> {

    lazy var authenticationScreen: AuthenticationScreen = {
        let screenModel = AuthenticationScreenModel()
        screenModel.onResult = { [weak self] result in
            switch result {
            case .didAuthenticate: self?.finishFlow?(.didAuthenticate)
            }
        }

        let screen = AuthenticationScreen.createWithNib(screenModel: screenModel)
        return screen
    }()

    // MARK: Coordinator

    override func toPresentable() -> UIViewController {
        return authenticationScreen
    }
}
