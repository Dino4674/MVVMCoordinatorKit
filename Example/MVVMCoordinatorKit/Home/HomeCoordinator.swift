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
        let todayCoordinator = createTodayCoordinator()
        let suggestedCoordinator = createSuggestedCoordinator()
        setupTabs(with: [todayCoordinator, suggestedCoordinator])
        addChild(todayCoordinator)
        addChild(suggestedCoordinator)
        todayCoordinator.start()
        suggestedCoordinator.start()
    }

    override func toPresentable() -> UIViewController {
        return tabBarController
    }

    // MARK: Tabs

    private func setupTabs(with coordinators: [Coordinator]) {
        tabBarController.setViewControllers(coordinators.map { $0.toPresentable() }, animated: false)
    }

    // MARK: Child Coordinators

    private func createTodayCoordinator() -> TodayCoordinator {
        let navigationController = UINavigationController()
        navigationController.tabBarItem = UITabBarItem(title: "Today", image: nil, selectedImage: nil)
        let router = Router(navigationController: navigationController)
        let coordinator = TodayCoordinator(router: router)
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

    private func createSuggestedCoordinator() -> SuggestedCoordinator {
        let navigationController = UINavigationController()
        navigationController.tabBarItem = UITabBarItem(title: "Suggested", image: nil, selectedImage: nil)
        let router = Router(navigationController: navigationController)
        let coordinator = SuggestedCoordinator(router: router)
        return coordinator
    }
}
