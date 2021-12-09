//
//  ShadowView.swift
//  FeedCards
//
//  Created by Daniel Oliveira on 09/12/21.
//

import UIKit

class ShadowView: UIView {
    
    // MARK: - Overrides
    
    override var bounds: CGRect {
        didSet {
            setupShadow()
        }
    }
    
    // MARK: - Private functions
    
    private func setupShadow() {
        layer.cornerRadius = 8
        layer.shadowOffset = CGSize(width: 0, height: 3)
        layer.shadowRadius = 3
        layer.shadowOpacity = 0.3
        layer.shadowPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: 8, height: 8)).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
    }
}
