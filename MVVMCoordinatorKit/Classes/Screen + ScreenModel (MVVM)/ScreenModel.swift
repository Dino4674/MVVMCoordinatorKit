//
//  ScreenModel.swift
//  MVVMCoordinatorKit
//
//  Created by Dino Bartosak on 11.07.2023.
//

import Foundation

public protocol ScreenModelType: AnyObject {
    associatedtype Input /// input FROM the view
    associatedtype Output /// output FOR the view
    associatedtype Result /// result FOR 'outside world' (Coordinator)
}

open class ScreenModel {
    deinit { MVVMCoordinatorKitLogger.log("💀 ScreenModel deinit: \(self)") }
    
    public init() {}
}
