//
//  AuthenticationScreen.swift
//  MVVMCoordinatorKit_Example
//
//  Created by Dino Bartosak on 05.09.2023.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import MVVMCoordinatorKit
import Combine

class AuthenticationScreen: Screen<AuthenticationScreenModel> {

    public var disposeBag = Set<AnyCancellable>()

    // MARK: Outlets

    @IBOutlet weak var authenticateButton: UIButton!
    
    // MARK: Screen Override

    override func setupUI() {

    }

    override func bindScreenModel() {
        screenModel.output.authenticateButtonTitle.receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] in
                self?.authenticateButton.setTitle($0, for: .normal)
            })
            .store(in: &disposeBag)
    }

    // MARK: Actions

    @IBAction func authenticateButtonTap(_ sender: Any) {
        screenModel.input.authenticate.send(())
    }
}
