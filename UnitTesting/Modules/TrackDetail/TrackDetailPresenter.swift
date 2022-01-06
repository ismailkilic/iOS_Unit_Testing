//
//  TrackDetailPresenter.swift
//  UnitTesting


import Foundation

class TrackDetailPresenter {

    // MARK: Properties

    weak var view: ITrackDetailView?
    var router: ITrackDetailRouter?
    var interactor: ITrackDetailInteractor?
    private var response: SearchResult?
}

extension TrackDetailPresenter: ITrackDetailPresenter {
    func buttonTapped() {
        router?.navigateToTrackOnStore(url: response?.trackViewURL)
    }

    func viewDidLoad() {
        interactor?.getTrackDetail()
    }
}

extension TrackDetailPresenter: ITrackDetailInteractorToPresenter {
    func getTrackRetrieved(model: SearchResult) {
        response = model

        if let url = URL(string: model.artworkUrl100 ?? "") {
            view?.setImageUrl(url: url)
        }
        view?.setTrackName(name: model.trackName)
        view?.setBrandName(name: "\(model.artistName ?? "")\n\(model.releaseDateFormated() ?? "")")

        view?.setTrackRating(rating: model.contentAdvisoryRating)
        view?.setPrimaryGenreName(name: model.primaryGenreName)
        if let longDescription = model.longDescription {
            view?.setDescriptionText(text: longDescription)
        } else if let description = model.description?.htmlToAttributedString {
            view?.setDescriptionAttributeText(attributedString: description)
        }

        if let price = model.trackPrice {
            view?.setPriceText(price: "\(price) \(model.currency ?? "")")
        } else {
            view?.setPriceText(price: "Free")
        }
    }

    func networkRequestFail(error: Error) {
        view?.showErrorAlert(message: error.localizedDescription)
    }
}
