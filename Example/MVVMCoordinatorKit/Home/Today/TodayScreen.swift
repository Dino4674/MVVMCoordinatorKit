//
//  TodayScreen.swift
//  CoordinatorExample
//
//  Created by Dino Bartosak on 14.07.2023..
//

import MVVMCoordinatorKit
import Combine

class TodayScreen: ModeledScreen<TodayScreenModel> {

    // MARK: Outlets

    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var label: UILabel!

    // MARK: BaseScreen Override

    override func setupUI() {
        view.backgroundColor = .lightGray
    }

    // MARK: ModeledScreen Override

    override func bindScreenModel() {
        screenModel.output.screenTitle.assign(to: \.text, on: label).store(in: &disposeBag)

        screenModel.output.logoutActionTitle.receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] in
                self?.logoutButton.setTitle($0, for: .normal)
            })
            .store(in: &disposeBag)
    }

    // MARK: Actions

    @IBAction func logoutTap(_ sender: Any) {
        screenModel.input.logout.send(())
    }
}
