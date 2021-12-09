//
//  UIImageViewExtension.swift
//  FeedCards
//
//  Created by Daniel Oliveira on 09/12/21.
//

import UIKit
import Kingfisher

extension UIImageView {
    func setImage(imageUrl: String) {
        self.kf.setImage(with: URL(string: imageUrl))
    }
}
