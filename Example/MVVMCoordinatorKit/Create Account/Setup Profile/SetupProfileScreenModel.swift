//
//  SetupProfileScreenModel.swift
//  CoordinatorExample
//
//  Created by Dino Bartosak on 14.07.2023..
//

import MVVMCoordinatorKit
import Combine

// MARK: - BaseScreenModelType

extension SetupProfileScreenModel: BaseScreenModelType {
    struct Input {
        let next: PassthroughSubject<Void, Never>
        let back: PassthroughSubject<Void, Never>
    }

    struct Output {
        let screenTitle: AnyPublisher<String?, Never>
        let backActionTitle: AnyPublisher<String?, Never>
        let nextActionTitle: AnyPublisher<String?, Never>
    }
}

// MARK: - BaseScreenModelResultType

extension SetupProfileScreenModel: BaseScreenModelResultType {
    struct ResultOutput {
        let next: AnyPublisher<Void, Never>
        let back: AnyPublisher<Void, Never>
    }
}

// MARK: - CreateAccountScreenModel

class SetupProfileScreenModel: ScreenModel {

    // MARK: BaseScreenModelType

    let input: Input
    let output: Output

    // MARK: BaseScreenModelResultType

    let resultOutput: ResultOutput

    // MARK: Init

    override init() {
        let next = PassthroughSubject<Void, Never>()
        let back = PassthroughSubject<Void, Never>()
        let screenTitle = CurrentValueSubject<String?, Never>("Setup Profile")
        let backActionTitle = CurrentValueSubject<String?, Never>("Go Back")
        let nextActionTitle = CurrentValueSubject<String?, Never>("Continue")

        input = Input(next: next,
                      back: back)
        output = Output(screenTitle: screenTitle.eraseToAnyPublisher(),
                        backActionTitle: backActionTitle.eraseToAnyPublisher(),
                        nextActionTitle: nextActionTitle.eraseToAnyPublisher())
        resultOutput = ResultOutput(next: next.eraseToAnyPublisher(),
                                    back: back.eraseToAnyPublisher())
    }
}
