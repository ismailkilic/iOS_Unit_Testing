//
//  TrackDetailRouter.swift
//  UnitTesting


import Foundation
import UIKit

class TrackDetailRouter {

    // MARK: Properties

    weak var view: UIViewController?

    // MARK: Static methods

    static func setupModule(response: SearchResult) -> TrackDetailViewController {
        let viewController = UIStoryboard.loadViewController() as TrackDetailViewController
        let presenter = TrackDetailPresenter()
        let router = TrackDetailRouter()
        let interactor = TrackDetailInteractor(response: response)

        viewController.presenter =  presenter
        viewController.modalPresentationStyle = .fullScreen

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor

        router.view = viewController

        interactor.output = presenter

        return viewController
    }
}

extension TrackDetailRouter: ITrackDetailRouter {
    func navigateToTrackOnStore(url: String?) {
        if let url = URL(string: url ?? ""),
           UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            print("Can't Open URL on Simulator")
        }
    }
}
