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

    private lazy var appNavigationController = UINavigationController()
    private lazy var appRouter = Router(navigationController: appNavigationController)
    private lazy var appCoordinator = AppCoordinator(router: appRouter)

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        // Disabled by default. Used for debug purposes to ensure memory management is working as expected.
        MVVMCoordinatorKitLogger.loggingEnabled = true

        window?.rootViewController = appCoordinator.toPresentable()
        window?.makeKeyAndVisible()
        appCoordinator.start()

        return true
    }
}
