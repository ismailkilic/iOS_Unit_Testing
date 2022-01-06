//
//  ITunesSearchRouter.swift
//  UnitTesting


import Foundation
import UIKit

class ITunesSearchRouter {

    // MARK: Properties

    weak var view: UIViewController?

    // MARK: Static methods

    static func setupModule() -> ITunesSearchViewController {
        let viewController = UIStoryboard.loadViewController() as ITunesSearchViewController
        let presenter = ITunesSearchPresenter()
        let router = ITunesSearchRouter()
        let interactor = ITunesSearchInteractor()
        let adapter = ITunesListAdapter(presenter: presenter, delegate: presenter)
        let api = APIClient()

        viewController.presenter =  presenter
        viewController.modalPresentationStyle = .fullScreen
        viewController.adapter = adapter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor

        router.view = viewController

        interactor.output = presenter
        interactor.api = api

        return viewController
    }
}

extension ITunesSearchRouter: IITunesSearchRouter {
    func navigateToTrackDetail(response: SearchResult) {
        view?.navigationController?.pushViewController(TrackDetailRouter.setupModule(response: response), animated: true)
    }
}
