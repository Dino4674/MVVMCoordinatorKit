//
//  AppDelegate.swift
//  MVVMCoordinatorKit
//
//  Created by Dino Bartosak on 08/31/2023.
//  Copyright (c) 2023 Dino Bartosak. All rights reserved.
//

import MVVMCoordinatorKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    private lazy var appNavigationController: UINavigationController = UINavigationController()
    private lazy var appRouter: RouterType = Router(navigationController: appNavigationController)
    private lazy var appCoordinator: AppCoordinator = AppCoordinator(router: appRouter)

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        window?.rootViewController = appCoordinator.toPresentable()
        window?.makeKeyAndVisible()
        appCoordinator.start()

        return true
    }
}
