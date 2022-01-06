//
//  ITunesSearchInteractor.swift
//  UnitTesting


import Foundation

class ITunesSearchInteractor {

    private enum Constants {
        static let apiRetryLimit = 3
    }

    // MARK: Properties
    weak var output: IITunesSearchInteractorToPresenter?
    var api: APIClientInterface?
    private var apiErrorCounter = 0
}

extension ITunesSearchInteractor: IITunesSearchInteractor {
    func getITunesFilterList() -> [ITunesFilterEntity] {
        [.movies, .musics, .apps, .books]
    }

    func search(term: String, entity: String, offset: Int, limit: Int) {
        api?.search(
            term: term,
            entity: entity,
            offset: offset,
            limit: limit,
            completion: { [weak self] model in
                self?.output?.searchRetrieved(response: model)
            }, onError: { [weak self] error in
                self?.output?.apiError(error: error)
            })
    }
}
