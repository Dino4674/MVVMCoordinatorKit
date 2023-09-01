//
//  CreateAccountCoordinator.swift
//  CoordinatorExample
//
//  Created by Dino Bartosak on 07.07.2023.
//

import MVVMCoordinatorKit
import Combine

enum CreateAccountCoordinatorResult {
    case dismiss
    case accountCreated
}

class CreateAccountCoordinator: CoordinatorWithOutput<CreateAccountCoordinatorResult> {

    // MARK: Coordinator

    override func start() {
        toPresentable().modalPresentationStyle = .fullScreen
        setCreateAccountScreenAsRoot()
    }

    // MARK: Private

    private func setCreateAccountScreenAsRoot() {
        let screenModel = CreateAccountScreenModel()
        screenModel.resultOutput.back.receive(on: DispatchQueue.main).sink { [weak self] _ in
            self?.onOutput(.dismiss)
        }.store(in: &disposeBag)

        screenModel.resultOutput.next.receive(on: DispatchQueue.main).sink { [weak self] _ in
            self?.pushSetupProfileScreen()
        }
        .store(in: &disposeBag)

        let screen = CreateAccountScreen.create(screenModel: screenModel)
        router.setRootModule(screen, animated: false, completion: nil)
    }

    private func pushSetupProfileScreen() {
        let screenModel = SetupProfileScreenModel()
        screenModel.resultOutput.back.receive(on: DispatchQueue.main).sink { [weak self] _ in
            self?.router.popModule(animated: true)
        }.store(in: &disposeBag)

        screenModel.resultOutput.next.receive(on: DispatchQueue.main).sink { [weak self] _ in
            self?.pushInterestsScreen()
        }
        .store(in: &disposeBag)

        let screen = SetupProfileScreen.create(screenModel: screenModel)
        router.push(screen, animated: true, completion: nil)
    }

    private func pushInterestsScreen() {
        let screenModel = InterestsScreenModel()
        screenModel.resultOutput.back.receive(on: DispatchQueue.main).sink { [weak self] _ in
            self?.router.popModule(animated: true)
        }.store(in: &disposeBag)

        screenModel.resultOutput.next.receive(on: DispatchQueue.main).sink { [weak self] _ in
            self?.onOutput(.accountCreated)
        }
        .store(in: &disposeBag)

        let screen = InterestsScreen.create(screenModel: screenModel)
        router.push(screen, animated: true, completion: nil)
    }
}
