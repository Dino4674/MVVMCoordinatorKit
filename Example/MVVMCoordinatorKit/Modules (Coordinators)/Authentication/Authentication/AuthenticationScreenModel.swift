//
//  AuthenticationScreenModel.swift
//  MVVMCoordinatorKit_Example
//
//  Created by Dino Bartosak on 05.09.2023..
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import MVVMCoordinatorKit
import Combine

// MARK: - ScreenModel

extension AuthenticationScreenModel: ScreenModelType {
    struct Input {
        let authenticate: PassthroughSubject<Void, Never>
    }

    struct Output {
        let authenticateButtonTitle: AnyPublisher<String?, Never>
    }
}

extension AuthenticationScreenModel: ScreenModelResultType {
    struct ResultOutput {
        let didAuthenticate: AnyPublisher<Void, Never>
    }
}

// MARK: - AuthenticationScreenModel

class AuthenticationScreenModel: ScreenModel {
    let input: Input
    let output: Output
    let resultOutput: ResultOutput

    override init() {
        let authenticate = PassthroughSubject<Void, Never>()
        let authenticateButtonTitle = CurrentValueSubject<String?, Never>("Authenticate")

        input = Input(authenticate: authenticate)
        output = Output(authenticateButtonTitle: authenticateButtonTitle.eraseToAnyPublisher())
        resultOutput = ResultOutput(didAuthenticate: authenticate.eraseToAnyPublisher())
    }
}
