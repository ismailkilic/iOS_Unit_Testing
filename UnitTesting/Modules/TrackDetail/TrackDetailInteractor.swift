//
//  TrackDetailInteractor.swift
//  UnitTesting


import Foundation

class TrackDetailInteractor {

    // MARK: Properties

    weak var output: ITrackDetailInteractorToPresenter?
    private let response: SearchResult

    init(response: SearchResult) {
        self.response = response
    }
}

extension TrackDetailInteractor: ITrackDetailInteractor {
    func getTrackDetail() {
        output?.getTrackRetrieved(model: response)
    }
}
