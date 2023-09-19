//
//  HomeCoordinator.swift
//  CoordinatorExample
//
//  Created by Dino Bartosak on 14.07.2023.
//

import MVVMCoordinatorKit

enum HomeCoordinatorResult {
    case didLogout
}

class HomeCoordinator: Coordinator<DeepLinkOption, HomeCoordinatorResult> {

    private var tabBarController = UITabBarController()

    // MARK: Coordinator

    override func start(deepLink: DeepLinkType?) {
        let navigationExamplesCoordinator = createNavigationExamplesCoordinator()
        let profileCoordinator = createProfileCoordinator()
        setupTabs(with: [navigationExamplesCoordinator, profileCoordinator])
        addChild(navigationExamplesCoordinator)
        addChild(profileCoordinator)
        navigationExamplesCoordinator.start(deepLink: deepLink)
        profileCoordinator.start(deepLink: deepLink)
    }

    override func toPresentable() -> UIViewController {
        return tabBarController
    }

    // MARK: Tabs

    private func setupTabs(with coordinators: [BaseCoordinator<DeepLinkType>]) {
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

        coordinator.finishFlow = { [weak self] result in
            switch result {
            case .didLogout:
                self?.finishFlow?(.didLogout)
            }
        }

        return coordinator
    }
}
