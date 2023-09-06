//
//  OnboardingCoordinator.swift
//  CoordinatorExample
//
//  Created by Dino Bartosak on 07.07.2023.
//

import MVVMCoordinatorKit
import Combine

enum OnboardingCoordinatorResult {
    case authorized
}

class OnboardingCoordinator: CoordinatorWithOutput<OnboardingCoordinatorResult> {

    lazy var onboardingScreen: OnboardingScreen = {
        let onboardingScreenModel = OnboardingScreenModel()
        onboardingScreenModel.resultOutput.authorize.receive(on: DispatchQueue.main).sink { [weak self] _ in
            self?.presentCreateAccountCoordinator()
        }
        .store(in: &disposeBag)

        let onboardingScreen = OnboardingScreen.create(screenModel: onboardingScreenModel)
        return onboardingScreen
    }()

    // MAR: Coordinator

    override func start() {
        toPresentable().modalPresentationStyle = .fullScreen
    }

    override func toPresentable() -> UIViewController {
        return onboardingScreen
    }

    // MARK: Child Coordinators

    func presentCreateAccountCoordinator() {
        let router = Router(navigationController: UINavigationController())
        let coordinator = CreateAccountCoordinator(router: router)
        presentCoordinator(coordinator, animated: true)

        coordinator.outputPublisher
            .receive(on: DispatchQueue.main).sink { [weak self, weak coordinator] result in
            switch result {
            case .accountCreated:
                self?.router.dismissModule(animated: true)
                self?.removeChild(coordinator)
                self?.onOutput(.authorized)
            case .dismiss:
                self?.router.dismissModule(animated: true)
                self?.removeChild(coordinator)
            }
        }.store(in: &disposeBag)
    }
}
