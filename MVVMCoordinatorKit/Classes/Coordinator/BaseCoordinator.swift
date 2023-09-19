//
//  Coordinator.swift
//  MVVMCoordinatorKit
//
//  Created by Dino Bartosak on 15.09.2023.
//

import Foundation

open class BaseCoordinator<DeepLinkType>: NSObject, Presentable {

    deinit { MVVMCoordinatorKitLogger.log("💀 Coordinator deinit: \(self)") }

    private(set) var childCoordinators: [BaseCoordinator] = []

    public init(router: Router) {
        self.router = router
    }

    // MARK: Public

    public let router: Router

    open func start(deepLink: DeepLinkType?) {}

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

    // MARK: Presentable

    open func toPresentable() -> UIViewController {
        return router.toPresentable()
    }
}

// MARK: - Navigation Helpers

extension BaseCoordinator {
    public func pushScreen(_ screen: UIViewController, animated: Bool = true, onPop: RouterCompletion? = nil) {
        router.push(screen, animated: animated, completion: onPop)
    }

    public func pushCoordinator(_ coordinator: BaseCoordinator, deepLink: DeepLinkType? = nil, animated: Bool = true, onPop: RouterCompletion? = nil) {
        addChild(coordinator)
        coordinator.start(deepLink: deepLink)
        router.push(coordinator, animated: animated) { [weak self, weak coordinator] in
            self?.removeChild(coordinator)
            onPop?()
        }
    }

    public func setRootCoordinator(_ coordinator: BaseCoordinator, deepLink: DeepLinkType? = nil, animated: Bool = true, onPop: RouterCompletion? = nil) {
        addChild(coordinator)
        coordinator.start(deepLink: deepLink)
        router.setRootModule(coordinator, animated: animated) { [weak self, weak coordinator] in
            self?.removeChild(coordinator)
            onPop?()
        }
    }

    public func presentCoordinator(_ coordinator: BaseCoordinator, deepLink: DeepLinkType? = nil, animated: Bool = true, onDismiss: RouterCompletion? = nil) {
        addChild(coordinator)
        coordinator.start(deepLink: deepLink)
        router.present(coordinator, animated: animated) { [weak self, weak coordinator] in
            self?.removeChild(coordinator)
            onDismiss?()
        }
    }
}
