//
//  NavigationExamplesScreenModel.swift
//  MVVMCoordinatorKit_Example
//
//  Created by Dino Bartosak on 05.09.2023..
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import MVVMCoordinatorKit
import Combine

// MARK: - ScreenModelType

extension NavigationExamplesScreenModel: ScreenModelType {
    struct Input {
        let pushScreen: PassthroughSubject<Void, Never>
        let pushCoordinator: PassthroughSubject<Void, Never>
        let presentCoordinator: PassthroughSubject<Void, Never>
        let popDismiss: PassthroughSubject<Void, Never>
    }

    struct Output {
        let pushScreenButtonTitle: AnyPublisher<String?, Never>
        let pushCoordinatorButtonTitle: AnyPublisher<String?, Never>
        let presentCoordinatorButtonTitle: AnyPublisher<String?, Never>
        let popDismissButtonTitle: AnyPublisher<String?, Never>
        let popDismissButtonVisible: AnyPublisher<Bool, Never>
    }
}

// MARK: - ScreenModelResultType

extension NavigationExamplesScreenModel: ScreenModelResultType {
    struct ResultOutput {
        let pushScreen: AnyPublisher<Void, Never>
        let pushCoordinator: AnyPublisher<Void, Never>
        let presentCoordinator: AnyPublisher<Void, Never>
        let popDismiss: AnyPublisher<Void, Never>
    }
}

// MARK: - NavigationExamplesScreenModel

enum NavigationExamplesScreenRemoveType {
    case pop
    case dismiss
}

class NavigationExamplesScreenModel: ScreenModel {

    // MARK: ScreenModelType

    let input: Input
    let output: Output

    // MARK: ScreenModelResultType

    let resultOutput: ResultOutput

    // MARK: Init

    init(removeType: NavigationExamplesScreenRemoveType, popDismissButtonVisible: Bool) {
        let pushScreen = PassthroughSubject<Void, Never>()
        let pushCoordinator = PassthroughSubject<Void, Never>()
        let presentCoordinator = PassthroughSubject<Void, Never>()
        let popDismiss = PassthroughSubject<Void, Never>()

        let pushScreenButtonTitle = CurrentValueSubject<String?, Never>("Push Screen")
        let pushCoordinatorButtonTitle = CurrentValueSubject<String?, Never>("Push Coordinator")
        let presentCoordinatorButtonTitle = CurrentValueSubject<String?, Never>("Present Coordinator")
        let popDismissButtonVisible = CurrentValueSubject<Bool, Never>(popDismissButtonVisible)

        let removeTypeTitle: String?
        switch removeType {
        case .dismiss: removeTypeTitle = "Dismiss manually"
        case .pop: removeTypeTitle = "Pop manually"
        }
        let popDismissButtonTitle = CurrentValueSubject<String?, Never>(removeTypeTitle)

        input = Input(pushScreen: pushScreen,
                      pushCoordinator: pushCoordinator,
                      presentCoordinator: presentCoordinator,
                      popDismiss: popDismiss)

        output = Output(pushScreenButtonTitle: pushScreenButtonTitle.eraseToAnyPublisher(),
                        pushCoordinatorButtonTitle: pushCoordinatorButtonTitle.eraseToAnyPublisher(),
                        presentCoordinatorButtonTitle: presentCoordinatorButtonTitle.eraseToAnyPublisher(),
                        popDismissButtonTitle: popDismissButtonTitle.eraseToAnyPublisher(),
                        popDismissButtonVisible: popDismissButtonVisible.eraseToAnyPublisher())

        resultOutput = ResultOutput(pushScreen: pushScreen.eraseToAnyPublisher(),
                                    pushCoordinator: pushCoordinator.eraseToAnyPublisher(),
                                    presentCoordinator: presentCoordinator.eraseToAnyPublisher(),
                                    popDismiss: popDismiss.eraseToAnyPublisher())
    }
}
