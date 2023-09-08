//
//  CombineCoordinator.swift
//  MVVMCoordinatorKit
//
//  Created by Dino Bartosak on 11.07.2023.
//

import Combine

open class CombineCoordinator<OutputType>: Coordinator {

    // MARK: Dispose Bag

    public var disposeBag = Set<AnyCancellable>()

    // MARK: Coordinator Output

    private let outputPassthroughSubject = PassthroughSubject<OutputType, Never>()

    /// Each Coordinator is responsible for calling this when it is ready to pass some information to a parent Coordinator
    public func onOutput(_ result: OutputType) {
        outputPassthroughSubject.send(result)
    }

    /// Each Coordinator is responsible for listening to this publisher for results that it's child Coordinator is producing
    public var outputPublisher: AnyPublisher<OutputType, Never> {
        outputPassthroughSubject.eraseToAnyPublisher()
    }
}
