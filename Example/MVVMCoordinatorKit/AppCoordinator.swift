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
            setOnboardingCoordinatorAsRoot(animated: false)
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
                    self?.setOnboardingCoordinatorAsRoot(animated: false)
                    break
                }
            }
            .store(in: &coordinator.disposeBag)
    }

    // MARK: Onboarding Coordinator

    private func setOnboardingCoordinatorAsRoot(animated: Bool) {
        let coordinator = OnboardingCoordinator(router: router)

        setRootCoordinator(coordinator, animated: animated)

        coordinator.outputPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] result in
                switch result {
                case .authorized:
                    self?.setHomeCoordinatorAsRoot(animated: false)
                    break
                }
            }
            .store(in: &coordinator.disposeBag)
    }
}
