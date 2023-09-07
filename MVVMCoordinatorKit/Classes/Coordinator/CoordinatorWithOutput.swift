//
//  CoordinatorWithOutput.swift
//  MVVMCoordinatorKit
//
//  Created by Dino Bartosak on 11.07.2023.
//

import Combine

open class CoordinatorWithOutput<ResultType>: Coordinator {

    // MARK: Dispose Bag

    public var disposeBag = Set<AnyCancellable>()

    // MARK: Public

    public func pushCoordinator<T>(_ coordinator: CoordinatorWithOutput<T>, animated: Bool) {
        addChild(coordinator)
        coordinator.start()
        router.push(coordinator, animated: animated) { [weak self, weak coordinator] in
            self?.removeChild(coordinator)
        }
    }

    public func setRootCoordinator<T>(_ coordinator: CoordinatorWithOutput<T>, animated: Bool) {
        addChild(coordinator)
        coordinator.start()
        router.setRootModule(coordinator, animated: animated) { [weak self, weak coordinator] in
            self?.removeChild(coordinator)
        }
    }

    public func presentCoordinator<T>(_ coordinator: CoordinatorWithOutput<T>, animated: Bool) {
        addChild(coordinator)
        coordinator.start()
        router.present(coordinator, animated: animated) { [weak self, weak coordinator] in
            self?.removeChild(coordinator)
        }
    }

    // MARK: Cordinator Output

    private let outputPassthroughSubject = PassthroughSubject<ResultType, Never>()

    public func onOutput(_ result: ResultType) {
        outputPassthroughSubject.send(result)
    }

    public var outputPublisher: AnyPublisher<ResultType, Never> {
        outputPassthroughSubject.eraseToAnyPublisher()
    }
}
