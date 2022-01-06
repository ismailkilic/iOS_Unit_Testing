//
//  ITunesCollectionViewCell.swift
//  UnitTesting


import UIKit
import Kingfisher

class ITunesCollectionViewCell: UICollectionViewCell {


    @IBOutlet private weak var priceLabel: UILabel!
    @IBOutlet private weak var subTitleLabel: UILabel!
    @IBOutlet private weak var titleLabel: UILabel!

    @IBOutlet private weak var artworkImageView: UIImageView!

    func setup(model: SearchResult) {
        artworkImageView.kf.setImage(with: URL(string: model.artworkUrl100 ?? ""),
                                     options: [
                                        .scaleFactor(UIScreen.main.scale),
                                        .transition(.fade(1)),
                                        .cacheOriginalImage
                                     ])

        if let price = model.trackPrice {
            priceLabel.isHidden = false
            priceLabel.text = "\(price) \(model.currency ?? "")"
        } else {
            priceLabel.text = "Free"
        }

        titleLabel.text = model.trackName

        subTitleLabel.text = model.releaseDateFormated()
    }
}
