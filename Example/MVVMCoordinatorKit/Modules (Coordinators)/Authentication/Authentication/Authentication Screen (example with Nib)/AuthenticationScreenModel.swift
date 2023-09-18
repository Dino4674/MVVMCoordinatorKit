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
}

// MARK: - AuthenticationScreenModel

extension AuthenticationScreenModel {
    enum Result {
        case didAuthenticate
    }
}

class AuthenticationScreenModel: ScreenModel<AuthenticationScreenModel.Result> {

    public var disposeBag = Set<AnyCancellable>()

    let input: Input
    let output: Output

    override init() {
        let authenticate = PassthroughSubject<Void, Never>()
        let authenticateButtonTitle = CurrentValueSubject<String?, Never>("Authenticate")

        input = Input(authenticate: authenticate)
        output = Output(authenticateButtonTitle: authenticateButtonTitle.eraseToAnyPublisher())

        super.init()

        authenticate.receive(on: DispatchQueue.main).sink { [weak self] _ in
            self?.onResult?(.didAuthenticate)
        }.store(in: &disposeBag)
    }
}
