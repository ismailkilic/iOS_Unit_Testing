//
//  StoryboardLoadable.swift
//  UnitTesting
//
//  Created by İsmail KILIÇ on 30.09.2021.
//  Copyright © 2021 İsmail KILIÇ. All rights reserved.
//

import Foundation
import UIKit

protocol StoryboardLoadable {
    static func storyboardName() -> String
    static func storyboardIdentifier() -> String
}

extension StoryboardLoadable where Self: UIViewController {
    static func storyboardName() -> String {
        return String(describing: Self.self).replacingOccurrences(of: "ViewController", with: "")
    }

    static func storyboardIdentifier() -> String {
        return String(describing: Self.self).replacingOccurrences(of: "ViewController", with: "")
    }
}

extension StoryboardLoadable where Self: UITableViewController {
    static func storyboardName() -> String {
        return String(describing: Self.self).replacingOccurrences(of: "TableViewController", with: "")
    }

    static func storyboardIdentifier() -> String {
        return String(describing: Self.self).replacingOccurrences(of: "TableViewController", with: "")
    }
}
