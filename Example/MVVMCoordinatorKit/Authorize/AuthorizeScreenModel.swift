//
//  AuthorizeScreenModel.swift
//  CoordinatorExample
//
//  Created by Dino Bartosak on 11.07.2023.
//

import MVVMCoordinatorKit
import Combine

// MARK: - BaseScreenModelType

extension AuthorizeScreenModel: BaseScreenModelType {
    struct Input {
        let screenInputExample: PassthroughSubject<Void, Never>
    }

    struct Output {
        let screenOutputExample: AnyPublisher<String?, Never>
    }
}

// MARK: - BaseScreenModelResultType

extension AuthorizeScreenModel: BaseScreenModelResultType {
    struct ResultOutput {
        let resultOutputExample: AnyPublisher<Void, Never>
    }
}

// MARK: - AuthorizeScreenModel

class AuthorizeScreenModel: ScreenModel {

    // MARK: BaseScreenModelType

    let input: Input
    let output: Output

    // MARK: BaseScreenModelResultType

    let resultOutput: ResultOutput

    // MARK: Init

    override init() {
        let inputExample = PassthroughSubject<Void, Never>()
        let outputExample = CurrentValueSubject<String?, Never>("Some initial value")

        input = Input(screenInputExample: inputExample)
        output = Output(screenOutputExample: outputExample.eraseToAnyPublisher())
        resultOutput = ResultOutput(resultOutputExample: inputExample.eraseToAnyPublisher())
    }
}
