//
//  Router.swift
//  CoordinatorExample
//
//  Created by Dino Bartosak on 14.07.2023.
//

import UIKit

public class Router: NSObject, RouterType, UINavigationControllerDelegate {

    private var completions: [UIViewController: () -> Void]

    public let navigationController: UINavigationController

    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.completions = [:]
        super.init()
        self.navigationController.delegate = self
    }

    // MARK: Public

    public var rootViewController: UIViewController? {
        return navigationController.viewControllers.first
    }

    var hasRootController: Bool {
        return rootViewController != nil
    }

    // MARK: RouterType

    public func present(_ module: Presentable, animated: Bool = true) {
        navigationController.present(module.toPresentable(), animated: animated, completion: nil)
    }

    public func dismissModule(animated: Bool = true, completion: (() -> Void)? = nil) {
        navigationController.dismiss(animated: animated, completion: completion)
    }

    public func push(_ module: Presentable, animated: Bool = true, completion: (() -> Void)?) {
        let controller = module.toPresentable()

        // Avoid pushing UINavigationController onto stack
        guard controller is UINavigationController == false else { return }

        if let completion = completion {
            completions[controller] = completion
        }

        navigationController.pushViewController(controller, animated: animated)
    }

    public func popModule(animated: Bool = true)  {
        if let controller = navigationController.popViewController(animated: animated) {
            runCompletion(for: controller)
        }
    }

    public func setRootModule(_ module: Presentable, animated: Bool, completion: (() -> Void)?) {
        // Call all completions so all coordinators can be deallocated
        completions.forEach { $0.value() }
        completions.removeAll()

        if let completion = completion {
            completions[module.toPresentable()] = completion
        }
        navigationController.setViewControllers([module.toPresentable()], animated: animated)
    }

    public func popToRootModule(animated: Bool) {
        if let controllers = navigationController.popToRootViewController(animated: animated) {
            controllers.forEach { runCompletion(for: $0) }
        }
    }

    private func runCompletion(for controller: UIViewController) {
        guard let completion = completions[controller] else { return }
        completion()
        completions.removeValue(forKey: controller)
    }


    // MARK: Presentable

    public func toPresentable() -> UIViewController {
        return navigationController
    }

    // MARK: UINavigationControllerDelegate

    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        // Ensure the view controller is popping
        guard let poppedViewController = navigationController.transitionCoordinator?.viewController(forKey: .from),
              !navigationController.viewControllers.contains(poppedViewController) else {
            return
        }

        runCompletion(for: poppedViewController)
    }
}
