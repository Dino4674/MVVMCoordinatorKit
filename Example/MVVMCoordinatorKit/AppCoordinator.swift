//
//  AppCoordinator.swift
//  CoordinatorExample
//
//  Created by Dino Bartosak on 07.07.2023.
//

import MVVMCoordinatorKit

class AppCoordinator: CoordinatorWithOutput<Void> {

    // MARK: Coordinator

    override func start() {
        // check if user already logged in
        let userLoggedIn = true
        if userLoggedIn {
            setHomeCoordinatorAsRoot(animated: false)
        } else {
            setAuthenticationCoordinatorAsRoot(animated: false)
        }
    }

    // MARK: Home Coordinator

    private func setHomeCoordinatorAsRoot(animated: Bool) {
        let coordinator = HomeCoordinator(router: router)

        setRootCoordinator(coordinator, animated: animated)

        coordinator.outputPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] result in
                switch result {
                case .logout:
                    self?.setAuthenticationCoordinatorAsRoot(animated: false)
                }
            }
            .store(in: &coordinator.disposeBag)
    }

    // MARK: Authentication Coordinator

    private func setAuthenticationCoordinatorAsRoot(animated: Bool) {
        let coordinator = AuthenticationCoordinator(router: router)

        setRootCoordinator(coordinator, animated: animated)

        coordinator.outputPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] result in
                switch result {
                case .authenticated:
                    self?.setHomeCoordinatorAsRoot(animated: false)
                }
            }
            .store(in: &coordinator.disposeBag)
    }
}
