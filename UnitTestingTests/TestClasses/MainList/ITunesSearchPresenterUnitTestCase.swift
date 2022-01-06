//
//  ITunesSearchPresenterUnitTestCase.swift
//  UnitTestingTests

import Foundation
import XCTest

@testable import UnitTesting
class ITunesSearchPresenterUnitTestCase: XCTestCase {

    var sut: IITunesSearchPresenter = ITunesSearchPresenter()
    var interactor = ITunesSearchInteractorMock()
    var view = ITunesSearchViewMock()
    var router = ITunesSearchRouterMock()

    func makeAndResetSUT() {
        let presenter = ITunesSearchPresenter()
        interactor = ITunesSearchInteractorMock()
        view = ITunesSearchViewMock()
        router = ITunesSearchRouterMock()
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor

        interactor.output = presenter
        sut = presenter
    }

    override func setUp() {
        makeAndResetSUT()
    }

    override func tearDown() {
        makeAndResetSUT()
    }

    func testViewDidLoad() {
        //When
        sut.viewDidLoad?()
        //Then
        XCTAssertTrue(interactor.searchCalled,
                      "searchCalled çağrılmış olmalı.")
    }

    func testDidTappedListItem() {
        //Given
        let mockData: SearchResponse? = Bundle.main.decode("SearchResponse.json")
        interactor.searchResponse = mockData
        interactor.output?.searchRetrieved(response: mockData)

        let selectedindex = 1
        //When
        sut.didTapped(itemIndex: selectedindex)
        //Then
        XCTAssertTrue(router.navigateToTrackDetailCalled,
                      "navigateToTrackDetailCalled çağrılmış olmalı.")
    }

    func testGetResultList() {
        //Given
        let mockData: SearchResponse? = Bundle.main.decode("SearchResponse.json")
        interactor.searchResponse = mockData
        interactor.output?.searchRetrieved(response: mockData)

        let sutMockResultListCount = mockData?.resultCount ?? 0

        //When
        let sutResultListCount = sut.getResultList()?.count ?? 0

        //Then
        XCTAssertEqual(sutResultListCount,
                       sutMockResultListCount, "Mock data ve sut içerisindeki data aynı olmalı")
    }

    func testGetITunesFilterList() {
        //Given
        let mockData: [ITunesFilterEntity] = [.apps, .books, .movies, .musics]
        interactor.filterList = mockData

        //When
        let sutFilterList = sut.getITunesFilterList()

        //Then
        XCTAssertEqual(sutFilterList,
                       mockData, "Mock data ve sut içerisindeki data aynı olmalı")
    }

    func testLoadMoreList() {
        // Given
        let mockData: SearchResponse? = Bundle.main.decode("SearchResponse.json")
        interactor.searchResponse = mockData
        interactor.output?.searchRetrieved(response: mockData)

        let initItemsCount = sut.getResultList()?.count ?? 0

        // When
        sut.loadMoreSearchList()
        let itemsCount = sut.getResultList()?.count ?? 0

        // Then
        XCTAssertGreaterThan(itemsCount,
                             initItemsCount,
                             "Daha fazla yükle çağrılmış olmalı ve liste sayısı itemlar artmalı")
    }
}
