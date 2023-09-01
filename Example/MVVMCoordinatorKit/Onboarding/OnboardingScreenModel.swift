//
//  OnboardingScreenModel.swift
//  CoordinatorExample
//
//  Created by Dino Bartosak on 11.07.2023.
//

import MVVMCoordinatorKit
import Combine

extension OnboardingScreenModel: ScreenModelType {
    struct Input {
        let authorize: PassthroughSubject<Void, Never>
    }

    struct Output {
        let screenTitle: AnyPublisher<String?, Never>
        let authorizeButtonTitle: AnyPublisher<String?, Never>
    }
}

extension OnboardingScreenModel: ScreenModelResultType {
    struct ResultOutput {
        let authorize: AnyPublisher<Void, Never>
    }
}

class OnboardingScreenModel: ScreenModel {

    // MARK: ScreenModelType

    let input: Input
    let output: Output

    // MARK: ScreenModelResultType

    let resultOutput: ResultOutput

    // MARK: Init

    override init() {
        let authorize = PassthroughSubject<Void, Never>()
        let screenTitle = CurrentValueSubject<String?, Never>("Onboarding")
        let authorizeButtonTitle = CurrentValueSubject<String?, Never>("Authorize")

        input = Input(authorize: authorize)
        output = Output(screenTitle: screenTitle.eraseToAnyPublisher(),
                        authorizeButtonTitle: authorizeButtonTitle.eraseToAnyPublisher())
        resultOutput = ResultOutput(authorize: authorize.eraseToAnyPublisher())
    }
}
