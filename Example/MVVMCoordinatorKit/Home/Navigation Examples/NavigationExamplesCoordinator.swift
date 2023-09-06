//
//  NavigationExamplesCoordinator.swift
//  CoordinatorExample
//
//  Created by Dino Bartosak on 14.07.2023.
//

import MVVMCoordinatorKit

enum NavigationExamplesCoordinatorResult {
    case popDismiss
}

class NavigationExamplesCoordinator: CoordinatorWithOutput<NavigationExamplesCoordinatorResult> {

    private var rootScreen: NavigationExamplesScreen!

    let isRoot: Bool
    let popDismissButtonVisible: Bool
    init(router: RouterType, isRoot: Bool, popDismissButtonVisible: Bool) {
        self.isRoot = isRoot
        self.popDismissButtonVisible = popDismissButtonVisible
        super.init(router: router)
        self.rootScreen = createRootScreen()
    }

    override func start() {
        if isRoot {
            router.setRootModule(rootScreen, animated: false, completion: nil)
        }
    }

    override func toPresentable() -> UIViewController {
        isRoot ? super.toPresentable() : rootScreen
    }

    // MARK: Root Coordinator Screen

    private func createRootScreen() -> NavigationExamplesScreen {
        let screenModel = NavigationExamplesScreenModel(removeType: isRoot ? .dismiss : .pop,
                                                        popDismissButtonVisible: popDismissButtonVisible)

        screenModel.resultOutput.pushScreen.receive(on: DispatchQueue.main).sink { [weak self] _ in
            self?.pushScreenExample()
        }.store(in: &disposeBag)

        screenModel.resultOutput.pushCoordinator.receive(on: DispatchQueue.main).sink { [weak self] _ in
            _ = self?.pushCoordinatorExample()
        }.store(in: &disposeBag)

        screenModel.resultOutput.presentCoordinator.receive(on: DispatchQueue.main).sink { [weak self] _ in
            _ = self?.presentCoordinatorExample()
        }.store(in: &disposeBag)

        screenModel.resultOutput.popDismiss.receive(on: DispatchQueue.main).sink { [weak self] _ in
            self?.onOutput(.popDismiss)
        }.store(in: &disposeBag)

        let screen = NavigationExamplesScreen.create(screenModel: screenModel)
        return screen
    }

    // MARK: Push Screen Example

    private func pushScreenExample() {
        let screenModel = NavigationExamplesScreenModel(removeType: .pop, popDismissButtonVisible: true)

        screenModel.resultOutput.pushScreen.receive(on: DispatchQueue.main).sink { [weak self] _ in
            self?.pushScreenExample()
        }.store(in: &disposeBag)

        screenModel.resultOutput.pushCoordinator.receive(on: DispatchQueue.main).sink { [weak self] _ in
            self?.pushCoordinatorExample()
        }.store(in: &disposeBag)

        screenModel.resultOutput.presentCoordinator.receive(on: DispatchQueue.main).sink { [weak self] _ in
            self?.presentCoordinatorExample()
        }.store(in: &disposeBag)

        screenModel.resultOutput.popDismiss.receive(on: DispatchQueue.main).sink { [weak self] _ in
            self?.router.popModule(animated: true)
        }.store(in: &disposeBag)

        let screen = NavigationExamplesScreen.create(screenModel: screenModel)
        router.push(screen, animated: true, completion: nil)
    }

    // MARK: Push Coordinator Example

    private func pushCoordinatorExample(){
        let coordinator = NavigationExamplesCoordinator(router: router, isRoot: false, popDismissButtonVisible: true)
        pushCoordinator(coordinator, animated: true)

        coordinator.outputPublisher
            .receive(on: DispatchQueue.main).sink { [weak self, weak coordinator] result in
            switch result {
            case .popDismiss:
                self?.router.popModule(animated: true)
                self?.removeChild(coordinator)
            }
        }.store(in: &disposeBag)
    }

    // MARK: Present Coordinator Example

    private func presentCoordinatorExample() {
        let navigationController = UINavigationController()
        let router = Router(navigationController: navigationController)
        let coordinator = NavigationExamplesCoordinator(router: router, isRoot: true, popDismissButtonVisible: true)
        presentCoordinator(coordinator, animated: true)

        coordinator.outputPublisher
            .receive(on: DispatchQueue.main).sink { [weak self, weak coordinator] result in
            switch result {
            case .popDismiss:
                self?.router.dismissModule(animated: true)
                self?.removeChild(coordinator)
            }
        }.store(in: &disposeBag)
    }
}
