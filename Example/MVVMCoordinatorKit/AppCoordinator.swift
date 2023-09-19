//
//  AppCoordinator.swift
//  CoordinatorExample
//
//  Created by Dino Bartosak on 07.07.2023.
//

import MVVMCoordinatorKit

class AppCoordinator: Coordinator<DeepLinkOption, Void> {

    private var isAuthorized = false

    // MARK: Coordinator

    override func start(deepLink: DeepLinkType?) {

        // Here you can check your deep link and start a particular flow

        if isAuthorized {
            setHomeCoordinatorAsRoot(animated: false)
        } else {
            setAuthenticationCoordinatorAsRoot(animated: false)
        }
    }

    // MARK: Home Coordinator

    private func setHomeCoordinatorAsRoot(animated: Bool) {
        let coordinator = HomeCoordinator(router: router)

        setRootCoordinator(coordinator, animated: animated)

        coordinator.finishFlow = { [weak self] result in
            switch result {
            case .didLogout:
                self?.setAuthenticationCoordinatorAsRoot(animated: false)
            }
        }
    }

    // MARK: Authentication Coordinator

    private func setAuthenticationCoordinatorAsRoot(animated: Bool) {
        let coordinator = AuthenticationCoordinator(router: router)

        setRootCoordinator(coordinator, animated: animated)

        coordinator.finishFlow = { [weak self] result in
            switch result {
            case .didAuthenticate:
                self?.setHomeCoordinatorAsRoot(animated: false)
            }
        }
    }
}
