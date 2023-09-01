//
//  OnboardingScreenModel.swift
//  CoordinatorExample
//
//  Created by Dino Bartosak on 11.07.2023.
//

import MVVMCoordinatorKit
import Combine

// MARK: - BaseScreenModelType

extension OnboardingScreenModel: BaseScreenModelType {
    struct Input {
        let authorize: PassthroughSubject<Void, Never>
    }

    struct Output {
        let screenTitle: AnyPublisher<String?, Never>
        let authorizeButtonTitle: AnyPublisher<String?, Never>
    }
}

// MARK: - BaseScreenModelResultType

extension OnboardingScreenModel: BaseScreenModelResultType {
    struct ResultOutput {
        let authorize: AnyPublisher<Void, Never>
    }
}

// MARK: - OnboardingScreenModel

class OnboardingScreenModel: ScreenModel {

    // MARK: BaseScreenModelType

    let input: Input
    let output: Output

    // MARK: BaseScreenModelResultType

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
