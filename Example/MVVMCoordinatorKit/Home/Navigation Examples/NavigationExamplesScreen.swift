//
//  NavigationExamplesScreen.swift
//  MVVMCoordinatorKit_Example
//
//  Created by Dino Bartosak on 05.09.2023..
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import MVVMCoordinatorKit
import Combine

class NavigationExamplesScreen: ModeledScreen<NavigationExamplesScreenModel> {

    // MARK: Outlets

    @IBOutlet weak var popDismissButton: UIButton!
    @IBOutlet weak var pushScreenButton: UIButton!
    @IBOutlet weak var pushCoordinatorButton: UIButton!
    @IBOutlet weak var presentCoordinatorButton: UIButton!

    // MARK: Screen Override

    override func setupUI() {

    }

    // MARK: ModeledScreen Override

    override func bindScreenModel() {
        screenModel.output.popDismissButtonVisible.receive(on: DispatchQueue.main)
            .map { !$0 }
            .assign(to: \.isHidden, on: popDismissButton).store(in: &disposeBag)

        screenModel.output.popDismissButtonTitle.receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] in
                self?.popDismissButton.setTitle($0, for: .normal)
            })
            .store(in: &disposeBag)

        screenModel.output.pushScreenButtonTitle.receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] in
                self?.pushScreenButton.setTitle($0, for: .normal)
            })
            .store(in: &disposeBag)

        screenModel.output.pushCoordinatorButtonTitle.receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] in
                self?.pushCoordinatorButton.setTitle($0, for: .normal)
            })
            .store(in: &disposeBag)

        screenModel.output.presentCoordinatorButtonTitle.receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] in
                self?.presentCoordinatorButton.setTitle($0, for: .normal)
            })
            .store(in: &disposeBag)
    }

    // MARK: Actions

    @IBAction func pushScreenAction(_ sender: Any) {
        screenModel.input.pushScreen.send(())
    }

    @IBAction func pushCoordinatorAction(_ sender: Any) {
        screenModel.input.pushCoordinator.send(())
    }

    @IBAction func presentCoordinatorAction(_ sender: Any) {
        screenModel.input.presentCoordinator.send(())
    }

    @IBAction func popDismissButtonTap(_ sender: Any) {
        screenModel.input.popDismiss.send(())
    }
}
