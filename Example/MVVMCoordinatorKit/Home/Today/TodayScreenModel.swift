//
//  TodayScreenModel.swift
//  CoordinatorExample
//
//  Created by Dino Bartosak on 14.07.2023..
//

import MVVMCoordinatorKit
import Combine

// MARK: - ScreenModelType

extension TodayScreenModel: ScreenModelType {
    struct Input {
        let logout: PassthroughSubject<Void, Never>
    }

    struct Output {
        let screenTitle: AnyPublisher<String?, Never>
        let logoutActionTitle: AnyPublisher<String?, Never>
    }
}

// MARK: - ScreenModelResultType

extension TodayScreenModel: ScreenModelResultType {
    struct ResultOutput {
        let logout: AnyPublisher<Void, Never>
    }
}

// MARK: - TodayScreenModel

class TodayScreenModel: ScreenModel {

    // MARK: ScreenModelType

    let input: Input
    let output: Output

    // MARK: ScreenModelResultType

    let resultOutput: ResultOutput

    // MARK: Init

    override init() {
        let logout = PassthroughSubject<Void, Never>()
        let screenTitle = CurrentValueSubject<String?, Never>("Today")
        let logoutActionTitle = CurrentValueSubject<String?, Never>("Logout")

        input = Input(logout: logout)
        output = Output(screenTitle: screenTitle.eraseToAnyPublisher(),
                        logoutActionTitle: logoutActionTitle.eraseToAnyPublisher())
        resultOutput = ResultOutput(logout: logout.eraseToAnyPublisher())
    }
}
