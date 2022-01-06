//
//  UIStoryboard+Ext.swift
//  UnitTesting
//
//  Created by İsmail KILIÇ on 30.09.2021.
//  Copyright © 2021 İsmail KILIÇ. All rights reserved.
//

import Foundation
import UIKit

extension UIStoryboard {
    static func loadViewController<T>() -> T where T: StoryboardLoadable, T: UIViewController {
        return UIStoryboard(name: T.storyboardName(),
                            bundle: nil).instantiateViewController(withIdentifier: T.storyboardIdentifier()) as! T
    }
}
