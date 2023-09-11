//
//  CombineCoordinator.swift
//  MVVMCoordinatorKit
//
//  Created by Dino Bartosak on 11.07.2023.
//

import MVVMCoordinatorKit
import Combine

open class CombineCoordinator<ResultType>: Coordinator {

    // MARK: Dispose Bag

    public var disposeBag = Set<AnyCancellable>()

    // MARK: Coordinator Output

    private let resultPassthroughSubject = PassthroughSubject<ResultType, Never>()

    /// Each Coordinator is responsible for calling this when it is ready to pass some information to a parent Coordinator
    public func onResult(_ result: ResultType) {
        resultPassthroughSubject.send(result)
    }

    /// Each Coordinator is responsible for listening to this publisher for results that it's child Coordinator is producing
    public var resultPublisher: AnyPublisher<ResultType, Never> {
        resultPassthroughSubject.eraseToAnyPublisher()
    }
}
