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
}

extension ProfileScreenModel {
    enum Result {
        case didLogout
    }
}

// MARK: - ProfileScreenModel

class ProfileScreenModel: ScreenModel<ProfileScreenModel.Result> {

    public var disposeBag = Set<AnyCancellable>()

    let input: Input
    let output: Output

    override init() {
        let logout = PassthroughSubject<Void, Never>()
        let screenTitle = CurrentValueSubject<String?, Never>("Profile")
        let logoutActionTitle = CurrentValueSubject<String?, Never>("Logout")

        input = Input(logout: logout)
        output = Output(screenTitle: screenTitle.eraseToAnyPublisher(),
                        logoutButtonTitle: logoutActionTitle.eraseToAnyPublisher())
        
        super.init()

        logout.receive(on: DispatchQueue.main).sink { [weak self] _ in
            self?.onResult?(.didLogout)
        }.store(in: &disposeBag)
    }
}
