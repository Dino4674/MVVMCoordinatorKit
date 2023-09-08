//
//  AuthenticationCoordinator.swift
//  MVVMCoordinatorKit_Example
//
//  Created by Dino Bartosak on 05.09.2023..
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import MVVMCoordinatorKit
import Combine

enum AuthenticationCoordinatorOutput {
    case didAuthenticate
}

class AuthenticationCoordinator: CombineCoordinator<AuthenticationCoordinatorOutput> {

    lazy var authenticationScreen: AuthenticationScreen = {
        let screenModel = AuthenticationScreenModel()
        screenModel.resultOutput.didAuthenticate.receive(on: DispatchQueue.main).sink { [weak self] _ in
            self?.onOutput(.didAuthenticate)
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
