//
//  TodayCoordinator.swift
//  CoordinatorExample
//
//  Created by Dino Bartosak on 14.07.2023.
//

import MVVMCoordinatorKit

enum TodayCoordinatorResult {
    case logout
}

class TodayCoordinator: CoordinatorWithOutput<TodayCoordinatorResult> {

    // MARK: Screens

    lazy var todayScreen: TodayScreen = {
        let screenModel = TodayScreenModel()
        let screen = TodayScreen.create(screenModel: screenModel)

        screenModel.resultOutput.logout.receive(on: DispatchQueue.main).sink { [weak self] _ in
            self?.onOutput(.logout)
        }.store(in: &screen.disposeBag)

        return screen
    }()

    // MARK: Coordinator

    override func start() {
        router.setRootModule(todayScreen, animated: false, completion: nil)
    }
}
