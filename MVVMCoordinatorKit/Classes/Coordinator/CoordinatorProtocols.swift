//
//  CoordinatorProtocols.swift
//  MVVMCoordinatorKit
//
//  Created by Dino Bartosak on 29.08.2023.
//

import UIKit

public protocol Presentable {
    func toPresentable() -> UIViewController
}

public protocol RouterType: AnyObject, Presentable {
    var navigationController: UINavigationController { get }
    var rootViewController: UIViewController? { get }
    func present(_ module: Presentable, animated: Bool)
    func dismissModule(animated: Bool, completion: (() -> Void)?)
    func push(_ module: Presentable, animated: Bool, completion: (() -> Void)?)
    func popModule(animated: Bool)
    func setRootModule(_ module: Presentable, animated: Bool, completion: (() -> Void)?)
    func popToRootModule(animated: Bool)
}

public protocol CoordinatorType: AnyObject, Presentable {
    func start()
    var router: RouterType { get }
}
