//
//  AuthenticationScreenModel.swift
//  MVVMCoordinatorKit_Example
//
//  Created by Dino Bartosak on 05.09.2023..
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
}

// MARK: - ScreenModelResultType

extension AuthenticationScreenModel: ScreenModelResultType {
    struct ResultOutput {
        let authenticated: AnyPublisher<Void, Never>
    }
}

// MARK: - AuthenticationScreenModel

class AuthenticationScreenModel: ScreenModel {

    // MARK: ScreenModelType

    let input: Input
    let output: Output

    // MARK: ScreenModelResultType

    let resultOutput: ResultOutput

    // MARK: Init

    override init() {
        let authenticate = PassthroughSubject<Void, Never>()
        let authenticateButtonTitle = CurrentValueSubject<String?, Never>("Authenticate")

        input = Input(authenticate: authenticate)
        output = Output(authenticateButtonTitle: authenticateButtonTitle.eraseToAnyPublisher())
        resultOutput = ResultOutput(authenticated: authenticate.eraseToAnyPublisher())
    }
}
