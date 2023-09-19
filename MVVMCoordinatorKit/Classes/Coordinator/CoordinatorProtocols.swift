//
//  CoordinatorProtocols.swift
//  MVVMCoordinatorKit
//
//  Created by Dino Bartosak on 15.09.2023.
//

import Foundation

public protocol BaseCoordinatorType: Presentable {
    associatedtype DeepLinkType
    func start(deepLink: DeepLinkType?)
    var router: Router { get }
}

public protocol CoordinatorOutputType {
    associatedtype CoordinatorOutput
    var finishFlow: ((CoordinatorOutput) -> ())? { get set }
}
