//
//  OnboardingScreen.swift
//  CoordinatorExample
//
//  Created by Dino Bartosak on 11.07.2023.
//

import MVVMCoordinatorKit
import Combine

class OnboardingScreen: ModeledScreen<OnboardingScreenModel> {

    // MARK: Outlets

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorizeButton: UIButton!

    // MARK: Screen

    override func setupUI() {

    }

    // MARK: ModeledScreen

    override func bindScreenModel() {
        screenModel.output.screenTitle.receive(on: DispatchQueue.main)
            .assign(to: \.text, on: titleLabel).store(in: &disposeBag)

        screenModel.output.authorizeButtonTitle.receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] in
                self?.authorizeButton.setTitle($0, for: .normal)
            })
            .store(in: &disposeBag)
    }

    // MARK: Actions

    @IBAction func authorizeTap(_ sender: Any) {
        screenModel.input.authorize.send(())
    }
}
