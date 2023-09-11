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

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        // Disabled by default. Used for debug purposes to ensure memory management is working as expected.
        MVVMCoordinatorKitLogger.loggingEnabled = true

        return true
    }
}
