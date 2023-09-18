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

class ProfileCoordinator: Coordinator<DeepLinkOption, ProfileCoordinatorResult> {

    // MARK: Screens

    lazy var profileScreen: ProfileScreen = {
        let screenModel = ProfileScreenModel()
        let screen = ProfileScreen.create(screenModel: screenModel)

        screenModel.onResult = { [weak self] result in
            switch result {
            case .didLogout: self?.finishFlow?(.didLogout)
            }
        }

        return screen
    }()

    // MARK: Coordinator

    override func start() {
        router.setRootModule(profileScreen, animated: false, completion: nil)
    }
}
