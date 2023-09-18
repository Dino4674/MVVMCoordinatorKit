//
//  Coordinator.swift
//  MVVMCoordinatorKit
//
//  Created by Dino Bartosak on 07.07.2023.
//

import UIKit

open class Coordinator<DeepLinkType, CoordinatorOutput>: BaseCoordinator<DeepLinkType>, CoordinatorOutputType {

    // MARK: CoordinatorType

    public var finishFlow: ((CoordinatorOutput) -> ())?
}
