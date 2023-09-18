//
//  CoordinatorProtocols.swift
//  MVVMCoordinatorKit
//
//  Created by Dino Bartosak on 15.09.2023.
//

import Foundation

public protocol BaseCoordinatorType: Presentable {
    associatedtype DeepLinkType
    var router: Router { get }
    func start()
    func start(deepLink: DeepLinkType?)
}

public protocol CoordinatorOutputType {
    associatedtype CoordinatorOutput
    var finishFlow: ((CoordinatorOutput) -> ())? { get set }
}
