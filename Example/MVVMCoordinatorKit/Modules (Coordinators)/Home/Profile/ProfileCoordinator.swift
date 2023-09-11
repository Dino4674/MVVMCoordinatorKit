//
//  ProfileCoordinator.swift
//  CoordinatorExample
//
//  Created by Dino Bartosak on 14.07.2023.
//

import MVVMCoordinatorKit

enum ProfileCoordinatorResult {
    case didLogout
}

class ProfileCoordinator: CombineCoordinator<ProfileCoordinatorResult> {

    // MARK: Screens

    lazy var profileScreen: ProfileScreen = {
        let screenModel = ProfileScreenModel()
        let screen = ProfileScreen.create(screenModel: screenModel)

        screenModel.result.didLogout.receive(on: DispatchQueue.main).sink { [weak self] _ in
            self?.onResult(.didLogout)
        }.store(in: &screen.disposeBag)

        return screen
    }()

    // MARK: Coordinator

    override func start() {
        router.setRootModule(profileScreen, animated: false, completion: nil)
    }
}
