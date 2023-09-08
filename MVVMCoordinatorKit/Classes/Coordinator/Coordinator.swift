//
//  Coordinator.swift
//  MVVMCoordinatorKit
//
//  Created by Dino Bartosak on 07.07.2023.
//

import UIKit

open class Coordinator: NSObject, Presentable {

    private(set) var childCoordinators: [Coordinator] = []
    public let router: Router

    public init(router: Router) {
        self.router = router
    }

    deinit { MVVMCoordinatorKitLogger.log("💀 Coordinator deinit: \(self)") }

    // MARK: Start (Needs Override)

    open func start() {
        fatalError("Override 'start' function")
    }

    // MARK: Presentable

    open func toPresentable() -> UIViewController {
        return router.toPresentable()
    }

    // MARK: Child Coordinators

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

// MARK: - Navigation Helpers

extension Coordinator {
    public func pushScreen(_ screen: UIViewController, animated: Bool = true, onPop: RouterCompletion? = nil) {
        router.push(screen, animated: animated, completion: onPop)
    }

    public func pushCoordinator(_ coordinator: Coordinator, animated: Bool = true, onPop: RouterCompletion? = nil) {
        addChild(coordinator)
        coordinator.start()
        router.push(coordinator, animated: animated) { [weak self, weak coordinator] in
            self?.removeChild(coordinator)
            onPop?()
        }
    }

    public func setRootCoordinator(_ coordinator: Coordinator, animated: Bool = true, onPop: RouterCompletion? = nil) {
        addChild(coordinator)
        coordinator.start()
        router.setRootModule(coordinator, animated: animated) { [weak self, weak coordinator] in
            self?.removeChild(coordinator)
            onPop?()
        }
    }

    public func presentCoordinator(_ coordinator: Coordinator, animated: Bool = true, onDismiss: RouterCompletion? = nil) {
        addChild(coordinator)
        coordinator.start()
        router.present(coordinator, animated: animated) { [weak self, weak coordinator] in
            self?.removeChild(coordinator)
            onDismiss?()
        }
    }
}
