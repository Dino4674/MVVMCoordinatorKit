//
//  SuggestedCoordinator.swift
//  CoordinatorExample
//
//  Created by Dino Bartosak on 14.07.2023.
//

import MVVMCoordinatorKit

class SuggestedCoordinator: CoordinatorWithOutput<Void> {

    lazy var suggestedScreen: UIViewController = {
        let controller = UIViewController()
        controller.view.backgroundColor = .lightGray
        return controller
    }()

    override func start() {
        router.setRootModule(suggestedScreen, animated: false, completion: nil)
    }
}
