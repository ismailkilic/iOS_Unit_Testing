//
//  ITunesListAdapter.swift
//  UnitTesting


import Foundation
import UIKit

class ITunesListAdapter: NSObject {
    var cellSize = CGSize(width: 0, height: 0)

    private let presenter: IITunesSearchPresenter
    private weak var delegate: ITunesHeaderCellDelegate?
    private var isEmptyState = false

    init(presenter: IITunesSearchPresenter,
         delegate: ITunesHeaderCellDelegate?) {
        self.presenter = presenter
        self.delegate = delegate
        super.init()
    }
}



extension ITunesListAdapter: IBaseAdapter {
    func itemCount() -> Int {
        presenter.getResultList()?.count ?? 0
    }
}

extension ITunesListAdapter: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if presenter.getResultList() != nil && itemCount() == 0 {
            collectionView.setEmptyMessage("No one here 🤌 \n Please change the search")
            isEmptyState = true
         } else {
            collectionView.restore()
             isEmptyState = false
         }

        return itemCount()
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let index = indexPath.row

        let model = presenter.getResultList()?[index]
        let cell: ITunesCollectionViewCell = collectionView.dequeue(for: indexPath)

        if let model = model {
            cell.setup(model: model)
        }

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                         withReuseIdentifier: ITunesHeaderCollectionReusableView.nameOfClass,
                                                                         for: indexPath)
        guard let typedHeaderView = headerView as? ITunesHeaderCollectionReusableView else { return headerView }

        typedHeaderView.setup(filterItems: presenter.getITunesFilterList(), delegate: delegate)
        return typedHeaderView
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        CGSize(width: collectionView.frame.width, height: 100)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let flowayout = collectionViewLayout as? UICollectionViewFlowLayout
        let space: CGFloat = (flowayout?.minimumInteritemSpacing ?? 0.0) + (flowayout?.sectionInset.left ?? 0.0) + (flowayout?.sectionInset.right ?? 0.0)
        let size: CGFloat = (collectionView.frame.size.width - space) / 2.0
        return CGSize(width: size, height: size * 1.5)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let index = indexPath.row
        presenter.didTapped(itemIndex: index)
    }
}

extension ITunesListAdapter: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        if let index = indexPaths.last?.row, index > itemCount() - 5 {
            presenter.loadMoreSearchList()
        }
    }
}
