//
//  SetupProfileScreen.swift
//  CoordinatorExample
//
//  Created by Dino Bartosak on 14.07.2023.
//

import MVVMCoordinatorKit
import Combine

class SetupProfileScreen: ModeledScreen<SetupProfileScreenModel> {

    // MARK: Outlets

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var goBackButton: UIButton!

    // MARK: Screen Override

    override func setupUI() {

    }

    // MARK: ModeledScreen Override

    override func bindScreenModel() {
        screenModel.output.screenTitle.receive(on: DispatchQueue.main)
            .assign(to: \.text, on: label).store(in: &disposeBag)

        screenModel.output.backActionTitle.receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] in
                self?.goBackButton.setTitle($0, for: .normal)
            })
            .store(in: &disposeBag)

        screenModel.output.nextActionTitle.receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] in
                self?.continueButton.setTitle($0, for: .normal)
            })
            .store(in: &disposeBag)
    }

    // MARK: Actions

    @IBAction func goBackTap(_ sender: Any) {
        screenModel.input.back.send(())
    }

    @IBAction func continueTap(_ sender: Any) {
        screenModel.input.next.send(())
    }
}
