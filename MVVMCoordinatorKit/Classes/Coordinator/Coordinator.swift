//
//  Coordinator.swift
//  MVVMCoordinatorKit
//
//  Created by Dino Bartosak on 07.07.2023.
//

import UIKit

open class Coordinator: NSObject, CoordinatorType {

    // MARK: Init/Deinit

    deinit { MVVMCoordinatorKitLogger.log("💀 Coordinator deinit: \(self)") }

    public init(router: RouterType) {
        self.router = router
    }

    // MARK: CoordinatorType

    public let router: RouterType

    open func start() {
        fatalError("Override 'start' function")
    }

    // MARK: Presentable

    open func toPresentable() -> UIViewController {
        return router.toPresentable()
    }

    // MARK: Child Coordinators

    private(set) var childCoordinators: [Coordinator] = []

    public func addChild(_ coordinator: Coordinator) {
        MVVMCoordinatorKitLogger.log("⚪ Add child coordinator: \(coordinator) to \(self)")
        childCoordinators.append(coordinator)
    }

    public func removeChild(_ coordinator: Coordinator?) {
        MVVMCoordinatorKitLogger.log("⚫ Remove child coordinator: \(String(describing: coordinator)) from \(self)")
        if let coordinator = coordinator, let index = childCoordinators.firstIndex(of: coordinator) {
            childCoordinators.remove(at: index)
        }
    }
}
