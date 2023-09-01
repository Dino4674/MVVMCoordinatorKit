//
//  ScreenModel.swift
//  CoordinatorExample
//
//  Created by Dino Bartosak on 11.07.2023.
//

import Foundation

public protocol ScreenModelType: AnyObject {
    associatedtype Input /// input from view
    associatedtype Output /// output for view
}

public protocol ScreenModelResultType: AnyObject {
    associatedtype ResultOutput /// output for 'outside world' (e.g. coordinator)
}

open class ScreenModel {
    deinit { print("💀 BaseScreenModel deinit -> \(self)") }

    public init() {}
}
