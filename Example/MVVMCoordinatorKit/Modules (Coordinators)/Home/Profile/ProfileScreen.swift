//
//  ProfileScreen.swift
//  CoordinatorExample
//
//  Created by Dino Bartosak on 14.07.2023..
//

import MVVMCoordinatorKit
import Combine

class ProfileScreen: Screen<ProfileScreenModel> {

    public var disposeBag = Set<AnyCancellable>()

    // MARK: Outlets

    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var label: UILabel!

    // MARK: Screen Override

    override func setupUI() {

    }

    override func bindScreenModel() {
        screenModel.output.screenTitle.assign(to: \.text, on: label).store(in: &disposeBag)

        screenModel.output.logoutButtonTitle.receive(on: DispatchQueue.main)
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
