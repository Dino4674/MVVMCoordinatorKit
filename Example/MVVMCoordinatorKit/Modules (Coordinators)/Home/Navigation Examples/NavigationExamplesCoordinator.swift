//
//  NavigationExamplesCoordinator.swift
//  CoordinatorExample
//
//  Created by Dino Bartosak on 14.07.2023.
//

import MVVMCoordinatorKit

enum NavigationExamplesCoordinatorOutput {
    case removeManually
}

class NavigationExamplesCoordinator: CombineCoordinator<NavigationExamplesCoordinatorOutput> {

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

        screenModel.resultOutput.pushScreen.receive(on: DispatchQueue.main).sink { [weak self] _ in
            self?.pushScreenExample()
        }.store(in: &disposeBag)

        screenModel.resultOutput.pushCoordinator.receive(on: DispatchQueue.main).sink { [weak self] _ in
            _ = self?.pushCoordinatorExample()
        }.store(in: &disposeBag)

        screenModel.resultOutput.presentCoordinator.receive(on: DispatchQueue.main).sink { [weak self] _ in
            _ = self?.presentCoordinatorExample()
        }.store(in: &disposeBag)

        screenModel.resultOutput.manualRemove.receive(on: DispatchQueue.main).sink { [weak self] _ in
            self?.onOutput(.removeManually)
        }.store(in: &disposeBag)

        let screen = NavigationExamplesScreen.create(screenModel: screenModel)
        return screen
    }

    // MARK: Push Screen Example

    private func pushScreenExample() {
        let screenModel = NavigationExamplesScreenModel(manualRemoveType: .pop)

        screenModel.resultOutput.pushScreen.receive(on: DispatchQueue.main).sink { [weak self] _ in
            self?.pushScreenExample()
        }.store(in: &disposeBag)

        screenModel.resultOutput.pushCoordinator.receive(on: DispatchQueue.main).sink { [weak self] _ in
            self?.pushCoordinatorExample()
        }.store(in: &disposeBag)

        screenModel.resultOutput.presentCoordinator.receive(on: DispatchQueue.main).sink { [weak self] _ in
            self?.presentCoordinatorExample()
        }.store(in: &disposeBag)

        screenModel.resultOutput.manualRemove.receive(on: DispatchQueue.main).sink { [weak self] _ in
            self?.router.popModule(animated: true)
        }.store(in: &disposeBag)

        let screen = NavigationExamplesScreen.create(screenModel: screenModel)
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

        coordinator.outputPublisher
            .receive(on: DispatchQueue.main).sink { [weak self] result in
            switch result {
            case .removeManually:
                self?.router.popModule(animated: true)
            }
        }.store(in: &disposeBag)
    }

    // MARK: Present Coordinator Example

    private func presentCoordinatorExample() {
        let navigationController = UINavigationController()
        let router = Router(navigationController: navigationController)
        let coordinator = NavigationExamplesCoordinator(router: router, isRoot: true, manualRemoveType: .dismiss)
        presentCoordinator(coordinator) {
            print("Do something if you need on coordinator dismiss")
        }

        coordinator.outputPublisher
            .receive(on: DispatchQueue.main).sink { [weak self] result in
            switch result {
            case .removeManually:
                self?.router.dismissModule(animated: true)
            }
        }.store(in: &disposeBag)
    }
}
