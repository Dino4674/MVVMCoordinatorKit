//
//  NavigationExamplesCoordinator.swift
//  CoordinatorExample
//
//  Created by Dino Bartosak on 14.07.2023.
//

import MVVMCoordinatorKit

enum NavigationExamplesCoordinatorResult {
    case removeManually
}

class NavigationExamplesCoordinator: Coordinator<DeepLinkOption, NavigationExamplesCoordinatorResult> {

    private var rootScreen: NavigationExamplesScreen!

    let isRoot: Bool
    let manualRemoveType: NavigationExamplesScreenModel.ManualRemoveType
    init(router: Router, isRoot: Bool, manualRemoveType: NavigationExamplesScreenModel.ManualRemoveType) {
        self.isRoot = isRoot
        self.manualRemoveType = manualRemoveType
        super.init(router: router)
        self.rootScreen = createRootScreen()
    }

    override func start() {
        // uncomment if you want this to present in full-screen mode
//        toPresentable().modalPresentationStyle = .fullScreen

        if isRoot {
            router.setRootModule(rootScreen, animated: false, completion: nil)
        }
    }

    override func toPresentable() -> UIViewController {
        isRoot ? super.toPresentable() : rootScreen
    }

    // MARK: Root Coordinator Screen

    private func createRootScreen() -> NavigationExamplesScreen {
        let screenModel = NavigationExamplesScreenModel(manualRemoveType: manualRemoveType)

        screenModel.onResult = { [weak self] result in
            switch result {
            case .pushScreen: self?.pushScreenExample()
            case .pushCoordinator: self?.pushCoordinatorExample()
            case .presentCoordinator: self?.presentCoordinatorExample()
            case .manualRemove: self?.finishFlow?(.removeManually)
            }
        }

        let screen = NavigationExamplesScreen.createWithNib(screenModel: screenModel)
        return screen
    }

    // MARK: Push Screen Example

    private func pushScreenExample() {
        let screenModel = NavigationExamplesScreenModel(manualRemoveType: .pop)

        screenModel.onResult = { [weak self] result in
            switch result {
            case .pushScreen: self?.pushScreenExample()
            case .pushCoordinator: self?.pushCoordinatorExample()
            case .presentCoordinator: self?.presentCoordinatorExample()
            case .manualRemove: self?.router.popModule(animated: true)
            }
        }

        let screen = NavigationExamplesScreen.createWithNib(screenModel: screenModel)
        pushScreen(screen) {
            print("Do something if you need on screen pop")
        }
    }

    // MARK: Push Coordinator Example

    private func pushCoordinatorExample(){
        let coordinator = NavigationExamplesCoordinator(router: router, isRoot: false, manualRemoveType: .pop)
        pushCoordinator(coordinator) {
            print("Do something if you need on coordinator pop")
        }

        coordinator.finishFlow = { [weak self] result in
            switch result {
            case .removeManually: self?.router.popModule(animated: true)
            }
        }
    }

    // MARK: Present Coordinator Example

    private func presentCoordinatorExample() {
        let navigationController = UINavigationController()
        let router = Router(navigationController: navigationController)
        let coordinator = NavigationExamplesCoordinator(router: router, isRoot: true, manualRemoveType: .dismiss)
        presentCoordinator(coordinator) {
            print("Do something if you need on coordinator dismiss")
        }

        coordinator.finishFlow = { [weak self] result in
            switch result {
            case .removeManually: self?.router.dismissModule(animated: true)
            }
        }
    }
}
