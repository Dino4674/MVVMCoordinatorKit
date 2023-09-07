//
//  MVVMCoordinatorKitLogger.swift
//  MVVMCoordinatorKit
//
//  Created by Dino Bartosak on 07.09.2023.
//

import Foundation

public class MVVMCoordinatorKitLogger {
    public static var loggingEnabled = false
    static func log(_ items: Any..., separator: String = " ", terminator: String = "\n") {
        guard loggingEnabled else { return }
        print(items, separator: separator, terminator: terminator)
    }
}
