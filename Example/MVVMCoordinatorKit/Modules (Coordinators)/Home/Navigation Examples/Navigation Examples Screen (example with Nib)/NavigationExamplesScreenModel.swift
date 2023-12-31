//
//  NavigationExamplesScreenModel.swift
//  MVVMCoordinatorKit_Example
//
//  Created by Dino Bartosak on 05.09.2023.
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
        let manualRemove: PassthroughSubject<Void, Never>
    }

    struct Output {
        let pushScreenButtonTitle: AnyPublisher<String?, Never>
        let pushCoordinatorButtonTitle: AnyPublisher<String?, Never>
        let presentCoordinatorButtonTitle: AnyPublisher<String?, Never>
        let manualRemoveButtonTitle: AnyPublisher<String?, Never>
        let manualRemoveButtonVisible: AnyPublisher<Bool, Never>
    }
}

// MARK: - NavigationExamplesScreenModel

enum NavigationExamplesScreenModelResult {
    case pushScreen
    case pushCoordinator
    case presentCoordinator
    case manualRemove
}


class NavigationExamplesScreenModel: ScreenModel<NavigationExamplesScreenModelResult> {
    enum ManualRemoveType {
        case pop
        case dismiss
        case none
    }

    public var disposeBag = Set<AnyCancellable>()

    let input: Input
    let output: Output

    init(manualRemoveType: ManualRemoveType) {
        let pushScreen = PassthroughSubject<Void, Never>()
        let pushCoordinator = PassthroughSubject<Void, Never>()
        let presentCoordinator = PassthroughSubject<Void, Never>()
        let manualRemove = PassthroughSubject<Void, Never>()

        let pushScreenButtonTitle = CurrentValueSubject<String?, Never>("Push Screen")
        let pushCoordinatorButtonTitle = CurrentValueSubject<String?, Never>("Push Coordinator")
        let presentCoordinatorButtonTitle = CurrentValueSubject<String?, Never>("Present Coordinator")
        let manualRemoveButtonVisible = CurrentValueSubject<Bool, Never>(manualRemoveType != .none)

        let manualRemoveTitle: String?
        switch manualRemoveType {
        case .dismiss: manualRemoveTitle = "Dismiss manually"
        case .pop: manualRemoveTitle = "Pop manually"
        case .none: manualRemoveTitle = nil
        }
        let manualRemoveButtonTitle = CurrentValueSubject<String?, Never>(manualRemoveTitle)

        input = Input(pushScreen: pushScreen,
                      pushCoordinator: pushCoordinator,
                      presentCoordinator: presentCoordinator,
                      manualRemove: manualRemove)

        output = Output(pushScreenButtonTitle: pushScreenButtonTitle.eraseToAnyPublisher(),
                        pushCoordinatorButtonTitle: pushCoordinatorButtonTitle.eraseToAnyPublisher(),
                        presentCoordinatorButtonTitle: presentCoordinatorButtonTitle.eraseToAnyPublisher(),
                        manualRemoveButtonTitle: manualRemoveButtonTitle.eraseToAnyPublisher(),
                        manualRemoveButtonVisible: manualRemoveButtonVisible.eraseToAnyPublisher())

        super.init()

        pushScreen.receive(on: DispatchQueue.main).sink { [weak self] _ in
            self?.onResult?(.pushScreen)
        }.store(in: &disposeBag)

        pushCoordinator.receive(on: DispatchQueue.main).sink { [weak self] _ in
            self?.onResult?(.pushCoordinator)
        }.store(in: &disposeBag)

        presentCoordinator.receive(on: DispatchQueue.main).sink { [weak self] _ in
            self?.onResult?(.presentCoordinator)
        }.store(in: &disposeBag)

        manualRemove.receive(on: DispatchQueue.main).sink { [weak self] _ in
            self?.onResult?(.manualRemove)
        }.store(in: &disposeBag)
    }
}
