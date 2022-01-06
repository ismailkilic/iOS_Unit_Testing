//
//  ITunesHeaderCollectionReusableView.swift
//  UnitTesting


import UIKit

protocol ITunesHeaderCellDelegate: AnyObject {
    func didChangedSearchText(text: String)
    func didChangeFilterItem(item: ITunesFilterEntity)
}


class ITunesHeaderCollectionReusableView: UICollectionReusableView {

    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var segmentedView: UISegmentedControl!

    private weak var delegate: ITunesHeaderCellDelegate?
    private var filterItems: [ITunesFilterEntity]?

    
    override func awakeFromNib() {
        super.awakeFromNib()


    }

    func setup(filterItems: [ITunesFilterEntity], delegate: ITunesHeaderCellDelegate?) {

        segmentedView.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .valueChanged)
        searchBar.delegate = self
        searchBar.placeholder = "Search"

        if #available(iOS 13.0, *) {
            searchBar.searchTextField.delegate = self
        }
        
        self.filterItems = filterItems
        for (index, element) in filterItems.enumerated() {
            if index <= segmentedView.numberOfSegments {
                segmentedView.setTitle(element.title, forSegmentAt: index)
            }
        }
        self.delegate = delegate
    }

    @objc func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        print(sender.selectedSegmentIndex)
        guard let item = filterItems?[sender.selectedSegmentIndex] else { return }
        delegate?.didChangeFilterItem(item: item)
    }
}

extension ITunesHeaderCollectionReusableView: UISearchBarDelegate, UITextFieldDelegate {

    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        DispatchQueue.main.async { [unowned self] in
            self.searchBar.endEditing(true)
        }
        return true
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(self.reload(_:)), object: searchBar)
        perform(#selector(self.reload(_:)), with: searchBar, afterDelay: 0.75)
    }

    @objc func reload(_ searchBar: UISearchBar) {

        delegate?.didChangedSearchText(text: searchBar.text ?? "")
    }
}

