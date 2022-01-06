//
//  TrackDetailViewController.swift
//  UnitTesting


import Foundation
import UIKit

class TrackDetailViewController: BaseViewController, StoryboardLoadable {

    @IBOutlet private weak var salePriceLabel: UILabel!
    @IBOutlet private weak var trackRatingLabel: UILabel!
    @IBOutlet private weak var ribbonTextLabel: UILabel!
    @IBOutlet private weak var ribbonContainerView: UIView!

    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var brandNameLabel: UILabel!
    @IBOutlet private weak var productImageView: ScaledHeightImageView!
    @IBOutlet private weak var trackNameLabel: UILabel!

    // MARK: Properties

    var presenter: ITrackDetailPresenter?

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad?()
    }

    @IBAction private func buttonTapped() {
        presenter?.buttonTapped()
    }
}

extension TrackDetailViewController: ITrackDetailView {
    func setDescriptionAttributeText(attributedString: NSMutableAttributedString?) {
        descriptionLabel.attributedText = attributedString
    }

    func setPriceText(price: String?) {
        salePriceLabel.text = price
    }

    func setDescriptionText(text: String?) {
        descriptionLabel.text = text
    }

    func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "Hata", message: message, preferredStyle: UIAlertController.Style.alert)

        alert.addAction(UIAlertAction(title: "Tamam", style: UIAlertAction.Style.default, handler: { [weak self] _ in
            self?.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }



    func setTrackRating(rating: String?) {
        if let rating = rating {
            trackRatingLabel.text = rating
        } else {
            trackRatingLabel.text = "-"
        }
    }

    func setPrimaryGenreName(name: String?) {
        if let text = name {
            ribbonTextLabel.text = text
        } else {
            ribbonContainerView.isHidden = true
        }

    }

    func setImageUrl(url: URL) {
        productImageView.kf.setImage(with: url)
    }

    func setBrandName(name: String?) {
        brandNameLabel.text = name
    }

    func setTrackName(name: String?) {
        trackNameLabel.text = name
    }
}

extension String {

    var htmlToAttributedString: NSMutableAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            return try NSMutableAttributedString(data: data,
                                                 options: [.documentType: NSMutableAttributedString.DocumentType.html,
                                                           .characterEncoding: String.Encoding.utf8.rawValue],
                                                 documentAttributes: nil)
        } catch let error as NSError {
            print(error.localizedDescription)
            return  nil
        }
    }
}
