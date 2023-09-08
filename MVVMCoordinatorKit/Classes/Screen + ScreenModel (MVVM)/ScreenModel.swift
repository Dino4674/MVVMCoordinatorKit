//
//  ScreenModel.swift
//  MVVMCoordinatorKit
//
//  Created by Dino Bartosak on 11.07.2023.
//

import Foundation

public protocol ScreenModelType: AnyObject {
    associatedtype Input /// input from view
    associatedtype Output /// output for view
}

public protocol ScreenModelResultType: AnyObject {
    associatedtype ResultOutput /// output for 'outside world' (Coordinator)
}

open class ScreenModel {
    deinit { MVVMCoordinatorKitLogger.log("💀 ScreenModel deinit: \(self)") }
    
    public init() {}
}
