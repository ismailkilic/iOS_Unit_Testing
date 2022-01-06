//
//  TrackDetailContract.swift
//  UnitTesting


import Foundation

protocol ITrackDetailView: IBaseView {
    func setImageUrl(url: URL)
    func setBrandName(name: String?)
    func setTrackName(name: String?)
    func setPrimaryGenreName(name: String?)
    func setTrackRating(rating: String?)
    func setDescriptionText(text: String?)
    func setDescriptionAttributeText(attributedString: NSMutableAttributedString?)
    func setPriceText(price: String?)

    func showErrorAlert(message: String)
}

protocol ITrackDetailPresenter: IBasePresenter {
    func buttonTapped()
}

protocol ITrackDetailInteractor: AnyObject {
    func getTrackDetail()
}

protocol ITrackDetailInteractorToPresenter: AnyObject {

    func getTrackRetrieved(model: SearchResult)
    func networkRequestFail(error: Error)
}

protocol ITrackDetailRouter: AnyObject {
    func navigateToTrackOnStore(url: String?)
}
