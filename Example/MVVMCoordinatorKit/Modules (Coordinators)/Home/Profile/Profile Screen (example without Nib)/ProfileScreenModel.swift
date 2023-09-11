//
//  ProfileScreenModel.swift
//  CoordinatorExample
//
//  Created by Dino Bartosak on 14.07.2023.
//

import MVVMCoordinatorKit
import Combine

// MARK: - ScreenModelType

extension ProfileScreenModel: ScreenModelType {
    struct Input {
        let logout: PassthroughSubject<Void, Never>
    }

    struct Output {
        let screenTitle: AnyPublisher<String?, Never>
        let logoutButtonTitle: AnyPublisher<String?, Never>
    }

    struct Result {
        let didLogout: AnyPublisher<Void, Never>
    }
}

// MARK: - ProfileScreenModel

class ProfileScreenModel: ScreenModel {
    let input: Input
    let output: Output
    let result: Result

    override init() {
        let logout = PassthroughSubject<Void, Never>()
        let screenTitle = CurrentValueSubject<String?, Never>("Profile")
        let logoutActionTitle = CurrentValueSubject<String?, Never>("Logout")

        input = Input(logout: logout)
        output = Output(screenTitle: screenTitle.eraseToAnyPublisher(),
                        logoutButtonTitle: logoutActionTitle.eraseToAnyPublisher())
        result = Result(didLogout: logout.eraseToAnyPublisher())
    }
}
