//
//  Coordinator.swift
//  MVVMCoordinatorKit
//
//  Created by Dino Bartosak on 07.07.2023.
//

import UIKit

open class Coordinator<DeepLinkType, ResultType>: BaseCoordinator<DeepLinkType>, CoordinatorResultType {

    // MARK: CoordinatorResultType

    public var finishFlow: ((ResultType) -> ())?
}
