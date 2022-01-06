//
//  ITunesSearchViewController.swift
//  UnitTesting


import Foundation
import UIKit

class ITunesSearchViewController: BaseViewController, StoryboardLoadable {

    // MARK: Properties
    @IBOutlet weak var collectionView: UICollectionView!
    private let refreshControl = UIRefreshControl()

    var presenter: IITunesSearchPresenter?
    var adapter: ITunesListAdapter?

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "ITunesSearch"
    }
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad?()
        prepareCollectionView()
    }

    private func prepareCollectionView() {
        collectionView.dataSource = adapter
        collectionView.delegate = adapter
        collectionView.prefetchDataSource = adapter
        collectionView.registerCell(ITunesCollectionViewCell.self)
        collectionView.registerSectionHeader(ITunesHeaderCollectionReusableView.self)
    }

    @objc private func refreshITunesSearch(_ sender: Any) {
        presenter?.refreshITunesSearch()
    }
}

extension ITunesSearchViewController: IITunesSearchView {
    func showErrorAlert(message: String) {
        let title = "Error"
        let buttonText = "OK"

        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: buttonText, style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)

        refreshControl.endRefreshing()
    }

    func reloadTableView() {
        collectionView.reloadData()
        refreshControl.endRefreshing()
    }
}
