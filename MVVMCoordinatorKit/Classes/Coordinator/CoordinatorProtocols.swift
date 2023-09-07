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

public typealias RouterCompletion = () -> Void

public protocol RouterType: AnyObject, Presentable {
    var navigationController: UINavigationController { get }
    var rootViewController: UIViewController? { get }

    func present(_ module: Presentable, animated: Bool, completion: RouterCompletion?)
    func dismissModule(animated: Bool)

    func push(_ module: Presentable, animated: Bool, completion: RouterCompletion?)
    func popModule(animated: Bool)

    func setRootModule(_ module: Presentable, animated: Bool, completion: RouterCompletion?)
    func popToRootModule(animated: Bool)
}

public protocol CoordinatorType: AnyObject, Presentable {
    func start()
    var router: RouterType { get }
}
