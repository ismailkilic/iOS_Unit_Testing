//
//  ITunesSearchViewMock.swift
//  UnitTestingTests

import Foundation

@testable import UnitTesting
public class ITunesSearchViewMock: IITunesSearchView {

    var reloadTableViewCalled = false
    var showErrorDialogCalled = false

    public func reloadTableView() {
        reloadTableViewCalled = true
    }

    public func showErrorAlert(message: String) {
        showErrorDialogCalled = true
    }

    public func showProgressHUD() { }

    public func hideProgressHUD() { }
}
