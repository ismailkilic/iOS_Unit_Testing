//
//  ITunesSearchContract.swift
//  UnitTesting


import Foundation
import  Alamofire

protocol IITunesSearchView: IBaseView {
    func reloadTableView()
    func showErrorAlert(message: String)
}

protocol IITunesSearchPresenter: IBasePresenter {
    func refreshITunesSearch()
    func getResultList() -> [SearchResult]?
    func loadMoreSearchList()
    func getITunesFilterList() -> [ITunesFilterEntity]
    func didTapped(itemIndex: Int)
}

protocol IITunesSearchInteractor: AnyObject {
    func search(term: String, entity: String, offset: Int, limit: Int)
    func getITunesFilterList() -> [ITunesFilterEntity]
}

protocol IITunesSearchInteractorToPresenter: AnyObject {
    func searchRetrieved(response: SearchResponse?)
    func apiError(error: AFError)
}

protocol IITunesSearchRouter: AnyObject {
    func navigateToTrackDetail(response: SearchResult)
}
