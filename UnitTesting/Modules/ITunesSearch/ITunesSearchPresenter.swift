//
//  ITunesSearchPresenter.swift
//  UnitTesting


import Foundation
import Alamofire

class ITunesSearchPresenter {

    // MARK: Properties

    weak var view: IITunesSearchView?
    var router: IITunesSearchRouter?
    var interactor: IITunesSearchInteractor?
    private(set) var resultList: [SearchResult]?
    private var nextPage: String?

    private var searchedText: String = "car"
    private var selectedFilterType: ITunesFilterEntity = .movies
    private var currentPage = 1
    private let limit = 25

    private var loadMoreCalled: Bool = false

    private func getListOffset() -> Int {
        limit * (currentPage - 1)
    }

    private func loadItems() {

        if searchedText.count > 2 {
            interactor?.search(term: searchedText, entity: selectedFilterType.paramValue, offset: getListOffset(), limit: limit)
        } else {
            resultList = []
            view?.reloadTableView()
        }
    }
}

extension ITunesSearchPresenter: IITunesSearchPresenter {
    func didTapped(itemIndex: Int) {
        guard let model = getResultList()?[itemIndex] else { return }
        router?.navigateToTrackDetail(response: model)
    }

    func getResultList() -> [SearchResult]? {
        resultList
    }

    func refreshITunesSearch() {
        currentPage = 1
        loadItems()
       // view?.showProgressHUD()
    }

    func loadMoreSearchList() {
        if let models = getResultList(),
           models.count % limit == 0,
           loadMoreCalled == false {
            loadMoreCalled = true
            currentPage += 1
            loadItems()
        }
    }

    func viewDidLoad() {
        refreshITunesSearch()
    }

    func getITunesFilterList() -> [ITunesFilterEntity] {
        interactor?.getITunesFilterList() ?? []
    }
}

extension ITunesSearchPresenter: ITunesHeaderCellDelegate {
    func didChangeFilterItem(item: ITunesFilterEntity) {
        selectedFilterType = item
        refreshITunesSearch()
    }

    func didChangedSearchText(text: String) {
        searchedText = text
        refreshITunesSearch()
    }
}

extension ITunesSearchPresenter: IITunesSearchInteractorToPresenter {

    func searchRetrieved(response: SearchResponse?) {
        let list = response?.results ?? []
        if loadMoreCalled {
            resultList?.append(contentsOf: list)
            loadMoreCalled = false
        } else {
            resultList = list
        }
        view?.reloadTableView()

    }

    func apiError(error: AFError) {
        view?.showErrorAlert(message: error.localizedDescription)
        view?.hideProgressHUD()
    }
}
