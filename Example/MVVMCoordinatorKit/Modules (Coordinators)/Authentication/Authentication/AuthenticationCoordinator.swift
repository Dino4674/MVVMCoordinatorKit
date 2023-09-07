//
//  AuthenticationCoordinator.swift
//  MVVMCoordinatorKit_Example
//
//  Created by Dino Bartosak on 05.09.2023..
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import MVVMCoordinatorKit
import Combine

enum AuthenticationCoordinatorResult {
    case authenticated
}

class AuthenticationCoordinator: CoordinatorWithOutput<AuthenticationCoordinatorResult> {

    lazy var authenticationScreen: AuthenticationScreen = {
        let screenModel = AuthenticationScreenModel()
        screenModel.resultOutput.authenticated.receive(on: DispatchQueue.main).sink { [weak self] _ in
            self?.onOutput(.authenticated)
        }.store(in: &disposeBag)

        let screen = AuthenticationScreen.create(screenModel: screenModel)
        return screen
    }()

    // MARK: Coordinator

    override func start() {

    }

    override func toPresentable() -> UIViewController {
        return authenticationScreen
    }
}
