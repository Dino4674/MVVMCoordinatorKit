//
//  Coordinator.swift
//  MVVMCoordinatorKit
//
//  Created by Dino Bartosak on 15.09.2023.
//

import Foundation

open class BaseCoordinator<DeepLinkType>: NSObject, BaseCoordinatorType {

    deinit { MVVMCoordinatorKitLogger.log("💀 Coordinator deinit: \(self)") }

    private(set) var childCoordinators: [BaseCoordinator] = []

    public init(router: Router) {
        self.router = router
    }

    // MARK: BaseCoordinatorType

    public let router: Router

    open func start() {
        start(deepLink: nil)
    }

    open func start(deepLink: DeepLinkType?) {

    }

    // MARK: Presentable

    open func toPresentable() -> UIViewController {
        return router.toPresentable()
    }

    // MARK: Child Coordinators

    public func addChild(_ coordinator: BaseCoordinator) {
        MVVMCoordinatorKitLogger.log("⚪ Add child coordinator: \(coordinator) to \(self)")
        childCoordinators.append(coordinator)
    }

    public func removeChild(_ coordinator: (BaseCoordinator)?) {
        MVVMCoordinatorKitLogger.log("⚫ Remove child coordinator: \(String(describing: coordinator)) from \(self)")
        if let coordinator = coordinator, let index = childCoordinators.firstIndex(of: coordinator) {
            childCoordinators.remove(at: index)
        }
    }
}

// MARK: - Navigation Helpers

extension BaseCoordinator {
    public func pushScreen(_ screen: UIViewController, animated: Bool = true, onPop: RouterCompletion? = nil) {
        router.push(screen, animated: animated, completion: onPop)
    }

    public func pushCoordinator(_ coordinator: BaseCoordinator, animated: Bool = true, onPop: RouterCompletion? = nil) {
        addChild(coordinator)
        coordinator.start()
        router.push(coordinator, animated: animated) { [weak self, weak coordinator] in
            self?.removeChild(coordinator)
            onPop?()
        }
    }

    public func setRootCoordinator(_ coordinator: BaseCoordinator, animated: Bool = true, onPop: RouterCompletion? = nil) {
        addChild(coordinator)
        coordinator.start()
        router.setRootModule(coordinator, animated: animated) { [weak self, weak coordinator] in
            self?.removeChild(coordinator)
            onPop?()
        }
    }

    public func presentCoordinator(_ coordinator: BaseCoordinator, animated: Bool = true, onDismiss: RouterCompletion? = nil) {
        addChild(coordinator)
        coordinator.start()
        router.present(coordinator, animated: animated) { [weak self, weak coordinator] in
            self?.removeChild(coordinator)
            onDismiss?()
        }
    }
}
