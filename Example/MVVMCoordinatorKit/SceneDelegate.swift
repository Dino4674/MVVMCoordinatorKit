//
//  SceneDelegate.swift
//  MVVMCoordinatorKit_Example
//
//  Created by Dino Bartosak on 11.09.2023.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import MVVMCoordinatorKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    private lazy var appNavigationController = UINavigationController()
    private lazy var appRouter = Router(navigationController: appNavigationController)
    private lazy var appCoordinator = AppCoordinator(router: appRouter)

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)

        guard let window = window else { return }
        window.rootViewController = appCoordinator.toPresentable()
        window.makeKeyAndVisible()
        appCoordinator.start()
    }
}
