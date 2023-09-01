//
//  AuthorizeScreen.swift
//  CoordinatorExample
//
//  Created by Dino Bartosak on 11.07.2023..
//

import MVVMCoordinatorKit
import Combine

class AuthorizeScreen: ModeledScreen<AuthorizeScreenModel> {

    // MARK: Outlets

    @IBOutlet weak var label: UILabel!

    // MARK: Screen Override

    override func setupUI() {

    }

    // MARK: ModeledScreen Override

    override func bindScreenModel() {
        screenModel.output.screenOutputExample.assign(to: \.text, on: label).store(in: &disposeBag)
    }
}
