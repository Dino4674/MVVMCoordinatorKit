//
//  BaseScreenModel.swift
//  CoordinatorExample
//
//  Created by Dino Bartosak on 11.07.2023.
//

import Foundation

public protocol BaseScreenModelType: AnyObject {
    associatedtype Input /// input from view
    associatedtype Output /// output for view
}

public protocol BaseScreenModelResultType: AnyObject {
    associatedtype ResultOutput /// output for 'outside world' (e.g. coordinator)
}

open class BaseScreenModel {

    // MARK: Deinit

    deinit {
        print("💀 BaseScreenModel deinit -> \(self)")
    }

    public init() {}
}
