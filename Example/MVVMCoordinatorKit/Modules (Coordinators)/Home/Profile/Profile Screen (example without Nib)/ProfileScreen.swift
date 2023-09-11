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

    private var logoutButton: UIBarButtonItem!

    // MARK: Screen Override

    override func setupUI() {
        view.backgroundColor = .white

        logoutButton = UIBarButtonItem(title: nil, style: .plain, target: self, action: #selector(logoutTap))
        navigationItem.rightBarButtonItem = logoutButton
    }

    override func bindScreenModel() {
        screenModel.output.screenTitle.receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] in
                self?.title = $0
            })
            .store(in: &disposeBag)

        screenModel.output.logoutButtonTitle.receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] in
                self?.logoutButton.title = $0
            })
            .store(in: &disposeBag)
    }

    // MARK: Actions

    @objc func logoutTap(_ sender: Any) {
        screenModel.input.logout.send(())
    }
}
