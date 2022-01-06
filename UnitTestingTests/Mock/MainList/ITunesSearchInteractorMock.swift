//
//  ITunesSearchInteractorMock.swift
//  UnitTestingTests

import Foundation
import Alamofire

@testable import UnitTesting
class ITunesSearchInteractorMock {

    weak var output: IITunesSearchInteractorToPresenter?
    var searchResponse: SearchResponse?
    var filterList: [ITunesFilterEntity]?

    var shouldSearchBeFail: Bool = false

    // MARK: Called Properties
    var searchCalled = false
    var getITunesFilterListCalled = false

}

extension ITunesSearchInteractorMock: IITunesSearchInteractor {
    func search(term: String, entity: String, offset: Int, limit: Int) {
        searchCalled = true


        if !shouldSearchBeFail {
            output?.searchRetrieved(response: searchResponse)
        } else {
            let error = NSError(domain:"", code:400, userInfo:[ NSLocalizedDescriptionKey: "MockError"]) as Error
            output?.apiError(error: error.asAFError(orFailWith: "Error"))
        }
    }

    func getITunesFilterList() -> [ITunesFilterEntity] {
        getITunesFilterListCalled = true
        return filterList ?? []
    }
}
