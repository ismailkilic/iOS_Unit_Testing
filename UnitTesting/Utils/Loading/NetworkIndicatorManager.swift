//
//  NetworkIndicatorManager.swift
//  UnitTesting
//
//  Created by İsmail KILIÇ on 30.09.2021.
//  Copyright © 2021 İsmail KILIÇ. All rights reserved.
//

import Foundation
import UIKit

class LoadingManager: NSObject {

    static let shared = LoadingManager()
    private var isShowing: Bool = false
    private var animationDuration = 0.25

    lazy var loadingContainerView: UIView = {
        let container: UIView = UIView()
        container.frame = UIScreen.main.bounds
        container.backgroundColor = .black.withAlphaComponent(0.5)

        let activityView = UIActivityIndicatorView(style: .whiteLarge)
        activityView.center = container.center
        container.addSubview(activityView)
        activityView.startAnimating()


        return container
    }()


    private override init() {
        super.init()
    }

    private var activityCount = 0 {
        didSet {
            DispatchQueue.main.async { [unowned self] in
                UIApplication.shared.isNetworkActivityIndicatorVisible = self.activityCount > 0
            }
        }
    }

    private var loadingCount = 0 {
        didSet {
            DispatchQueue.main.async { [unowned self] in
                if self.loadingCount > 0 {
                    self.showLoadingView()
                } else {
                    self.hideLoadingView()
                }
            }
        }
    }

    func showLoading() {
        activityCount += 1
        loadingCount += 1
    }

    func hideLoading() {
        if activityCount > 0 { activityCount -= 1 }
        if loadingCount > 0 { loadingCount -= 1 }
    }

    func showLoading(_ needToShowLoading: Bool) {
        activityCount += 1
        if needToShowLoading { loadingCount += 1 }
    }

    func hideLoading(_ needToShowLoading: Bool) {
        if activityCount > 0 { activityCount -= 1 }
        if needToShowLoading && loadingCount > 0 { loadingCount -= 1 }
    }
}

// MARK: View Handler
extension LoadingManager {
    private func showLoadingView() {
        if isShowing {
            return
        }

        if let window = UIApplication.shared.windows.filter({$0.isKeyWindow}).first {

            window.visibleViewController()?.view.addSubview(loadingContainerView)

            UIView.animate(withDuration: animationDuration) {
                self.loadingContainerView.alpha = 1.0
            }

            isShowing = true
        }
    }

    private func hideLoadingView() {
        if !isShowing {
            return
        }

        UIView.animate(withDuration: animationDuration, delay: 0.0, options: [], animations: {
            self.loadingContainerView.alpha = 0.0
        }, completion: { (_: Bool) in
            self.loadingContainerView.removeFromSuperview()
        })

        isShowing = false

    }

}
