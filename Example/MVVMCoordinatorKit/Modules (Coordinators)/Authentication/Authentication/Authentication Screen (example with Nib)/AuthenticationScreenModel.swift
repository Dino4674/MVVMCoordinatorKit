//
//  AuthenticationScreenModel.swift
//  MVVMCoordinatorKit_Example
//
//  Created by Dino Bartosak on 05.09.2023.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import MVVMCoordinatorKit
import Combine

// MARK: - ScreenModelType

extension AuthenticationScreenModel: ScreenModelType {
    struct Input {
        let authenticate: PassthroughSubject<Void, Never>
    }

    struct Output {
        let authenticateButtonTitle: AnyPublisher<String?, Never>
    }

    struct Result {
        let didAuthenticate: AnyPublisher<Void, Never>
    }
}

// MARK: - AuthenticationScreenModel

class AuthenticationScreenModel: ScreenModel {
    let input: Input
    let output: Output
    let result: Result

    override init() {
        let authenticate = PassthroughSubject<Void, Never>()
        let authenticateButtonTitle = CurrentValueSubject<String?, Never>("Authenticate")

        input = Input(authenticate: authenticate)
        output = Output(authenticateButtonTitle: authenticateButtonTitle.eraseToAnyPublisher())
        result = Result(didAuthenticate: authenticate.eraseToAnyPublisher())
    }
}
