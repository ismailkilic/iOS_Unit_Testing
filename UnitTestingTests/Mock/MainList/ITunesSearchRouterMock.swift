//
//  ITunesSearchRouterMock.swift
//  UnitTestingTests

import Foundation

@testable import UnitTesting
class ITunesSearchRouterMock {

    // MARK: Called Properties
    var navigateToTrackDetailCalled = false

}

extension ITunesSearchRouterMock: IITunesSearchRouter {
    func navigateToTrackDetail(response: SearchResult) {
        navigateToTrackDetailCalled = true
    }
}
