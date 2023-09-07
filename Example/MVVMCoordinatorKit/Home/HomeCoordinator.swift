//
//  HomeCoordinator.swift
//  CoordinatorExample
//
//  Created by Dino Bartosak on 14.07.2023.
//

import MVVMCoordinatorKit

enum HomeCoordinatorResult {
    case logout
}

class HomeCoordinator: CoordinatorWithOutput<HomeCoordinatorResult> {

    private var tabBarController = UITabBarController()

    // MARK: Coordinator

    override func start() {
        let navigationExamplesCoordinator = createNavigationExamplesCoordinator()
        let profileCoordinator = createProfileCoordinator()
        setupTabs(with: [navigationExamplesCoordinator, profileCoordinator])
        addChild(navigationExamplesCoordinator)
        addChild(profileCoordinator)
        navigationExamplesCoordinator.start()
        profileCoordinator.start()
    }

    override func toPresentable() -> UIViewController {
        return tabBarController
    }

    // MARK: Tabs

    private func setupTabs(with coordinators: [Coordinator]) {
        tabBarController.setViewControllers(coordinators.map { $0.toPresentable() }, animated: false)
    }

    // MARK: Child Coordinators

    private func createNavigationExamplesCoordinator() -> NavigationExamplesCoordinator {
        let navigationController = UINavigationController()
        navigationController.tabBarItem = UITabBarItem(title: "Navigation Examples", image: nil, selectedImage: nil)
        let router = Router(navigationController: navigationController)
        let coordinator = NavigationExamplesCoordinator(router: router, isRoot: true, manualRemoveType: .none)
        return coordinator
    }

    private func createProfileCoordinator() -> ProfileCoordinator {
        let navigationController = UINavigationController()
        navigationController.tabBarItem = UITabBarItem(title: "Profile", image: nil, selectedImage: nil)
        let router = Router(navigationController: navigationController)
        let coordinator = ProfileCoordinator(router: router)
        coordinator.outputPublisher.receive(on: DispatchQueue.main)
            .sink { [weak self] result in
                switch result {
                case .logout:
                    self?.onOutput(.logout)
                }
            }
            .store(in: &coordinator.disposeBag)
        return coordinator
    }
}
