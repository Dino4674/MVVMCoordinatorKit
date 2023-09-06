//
//  ProfileCoordinator.swift
//  CoordinatorExample
//
//  Created by Dino Bartosak on 14.07.2023.
//

import MVVMCoordinatorKit

enum ProfileCoordinatorResult {
    case logout
}

class ProfileCoordinator: CoordinatorWithOutput<ProfileCoordinatorResult> {

    // MARK: Screens

    lazy var profileScreen: ProfileScreen = {
        let screenModel = ProfileScreenModel()
        let screen = ProfileScreen.create(screenModel: screenModel)

        screenModel.resultOutput.onLogout.receive(on: DispatchQueue.main).sink { [weak self] _ in
            self?.onOutput(.logout)
        }.store(in: &screen.disposeBag)

        return screen
    }()

    // MARK: Coordinator

    override func start() {
        router.setRootModule(profileScreen, animated: false, completion: nil)
    }
}
