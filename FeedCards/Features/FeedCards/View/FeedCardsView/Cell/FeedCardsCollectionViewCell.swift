//
//  FeedCardsCollectionViewCell.swift
//  FeedCards
//
//  Created by Daniel Oliveira on 05/02/22.
//

import UIKit

class FeedCardsCollectionViewCell: UICollectionViewCell {
    // MARK: - Identifier
    
    static let identifier = "FeedCardsCollectionViewCell"
    
    // MARK: - Elements
    
    private lazy var containerView: UIView = {
        let containerView = UIView()
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = .size(.xSmall)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        return containerView
    }()
    
    private lazy var imageView: UIImageView = {
        var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setup(_ stringUrl: String) {
        setLayout()
        setImage(stringUrl)
    }
    
    // MARK: - Content Setting
    
    private func setImage(_ stringUrl: String) {
        downloadImage(stringUrl)
    }
    
    // MARK: - Private Functions
    
    private func downloadImage(_ stringImageUrl: String) {
        imageView.setImage(imageUrl: stringImageUrl)
        imageView.layer.cornerRadius = .size(.xSmall)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        DispatchQueue.main.async { [weak self] in
            self?.layoutIfNeeded()
        }
    }
    
    // MARK: - Layout
    
    private func setLayout() {
        setConstraintContainerLayout()
        setConstraintImageView()
    }
    
    private func setConstraintContainerLayout() {
        contentView.addSubview(containerView)
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    private func setConstraintImageView() {
        containerView.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: containerView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
    }
}
