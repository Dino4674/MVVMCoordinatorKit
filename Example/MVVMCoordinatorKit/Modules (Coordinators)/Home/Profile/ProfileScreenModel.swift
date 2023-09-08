//
//  ProfileScreenModel.swift
//  CoordinatorExample
//
//  Created by Dino Bartosak on 14.07.2023..
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
}

// MARK: - ScreenModelResultType

extension ProfileScreenModel: ScreenModelResultType {
    struct ResultOutput {
        let didLogout: AnyPublisher<Void, Never>
    }
}

// MARK: - ProfileScreenModel

class ProfileScreenModel: ScreenModel {

    // MARK: ScreenModelType

    let input: Input
    let output: Output

    // MARK: ScreenModelResultType

    let resultOutput: ResultOutput

    // MARK: Init

    override init() {
        let logout = PassthroughSubject<Void, Never>()
        let screenTitle = CurrentValueSubject<String?, Never>("Profile")
        let logoutActionTitle = CurrentValueSubject<String?, Never>("Logout")

        input = Input(logout: logout)
        output = Output(screenTitle: screenTitle.eraseToAnyPublisher(),
                        logoutButtonTitle: logoutActionTitle.eraseToAnyPublisher())
        resultOutput = ResultOutput(didLogout: logout.eraseToAnyPublisher())
    }
}
