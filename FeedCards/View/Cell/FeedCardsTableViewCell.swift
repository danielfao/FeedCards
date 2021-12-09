//
//  FeedCardsTableViewCell.swift
//  FeedCards
//
//  Created by Daniel Oliveira on 09/12/21.
//

import UIKit

protocol FeedCardsTableViewCellDelegate: AnyObject {
    func didTapFollow()
    func didTapShare()
}

class FeedCardsTableViewCell: UITableViewCell {
    
    // MARK: - Identifier
    
    static let identifier = "FeedCardsTableViewCell"
    
    // MARK: - Delegate
    
    public weak var delegate: FeedCardsTableViewCellDelegate?
    
    // MARK: - Private properties
    
    private var viewModel: FeedCardsViewModelProtocol?
    private var imagesFetched: Bool = false
    
    // MARK: - Private elements
    
    private lazy var containerView: UIView = {
        let containerView = UIView()
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 8
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        return containerView
    }()
    
    private lazy var shadowView: ShadowView = {
        let shadowView = ShadowView()
        shadowView.translatesAutoresizingMaskIntoConstraints = false
        
        return shadowView
    }()
    
    private lazy var tagView: UIView = {
        let tagView = UIView()
        tagView.layer.cornerRadius = 4
        tagView.translatesAutoresizingMaskIntoConstraints = false
        
        return tagView
    }()
    
    private lazy var tagLabel: UILabel = {
        let tagLabel = UILabel()
        tagLabel.textColor = .white
        tagLabel.textAlignment = .center
        tagLabel.numberOfLines = 1
        tagLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        tagLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return tagLabel
    }()
    
    private lazy var followButton: UIButton = {
        let spacing: CGFloat = 8.0
        let followButton = UIButton()
        followButton.backgroundColor = .systemOrange
        followButton.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        followButton.setTitle("FOLLOW", for: .normal)
        followButton.contentEdgeInsets = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        followButton.layer.cornerRadius = 4
        followButton.addTarget(self, action: #selector(didTapFollowButton), for: .touchUpInside)
        followButton.translatesAutoresizingMaskIntoConstraints = false
        
        return followButton
    }()
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.textColor = .black
        titleLabel.textAlignment = .natural
        titleLabel.numberOfLines = .zero
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return titleLabel
    }()
    
    private lazy var separatorLine: UIView = {
        let separatorLine = UIView()
        separatorLine.backgroundColor = .lightGray
        separatorLine.translatesAutoresizingMaskIntoConstraints = false
        
        return separatorLine
    }()
    
    private lazy var stackCardView: UIStackView = {
        let stackCardView = UIStackView()
        stackCardView.distribution = .fillEqually
        stackCardView.axis = .horizontal
        stackCardView.spacing = 16
        stackCardView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackCardView
    }()
    
    private lazy var postDescriptionLine: UIView = {
        let separatorLine = UIView()
        separatorLine.backgroundColor = .lightGray
        separatorLine.translatesAutoresizingMaskIntoConstraints = false
        
        return separatorLine
    }()
    
    private lazy var postDescriptionLabel: UILabel = {
        let postDescriptionLabel = UILabel()
        postDescriptionLabel.textColor = .black
        postDescriptionLabel.textAlignment = .natural
        postDescriptionLabel.numberOfLines = .zero
        postDescriptionLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        postDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return postDescriptionLabel
    }()
    
    private lazy var dateLabel: UILabel = {
        let dateLabel = UILabel()
        dateLabel.textColor = .lightGray
        dateLabel.numberOfLines = 1
        dateLabel.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return dateLabel
    }()
    
    private lazy var shareButton: UIButton = {
        let spacing: CGFloat = 8.0
        let shareButton = UIButton()
        shareButton.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        shareButton.setTitle("SHARE", for: .normal)
        shareButton.setTitleColor(.systemOrange, for: .normal)
        shareButton.setImage(UIImage(named: "share_icon"), for: .normal)
        shareButton.imageView?.tintColor = .systemOrange
        shareButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 0)
        shareButton.layer.cornerRadius = 4
        shareButton.addTarget(self, action: #selector(didTapShareButton), for: .touchUpInside)
        shareButton.translatesAutoresizingMaskIntoConstraints = false
        
        return shareButton
    }()
    
    // MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        selectionStyle = .none
    }
    
    public func setup(_ viewModel: FeedCardsViewModelProtocol) {
        self.viewModel = viewModel
        setCardContent(viewModel)
        setLayout(viewModel)
    }
    
    // MARK: - Objc Functions
    
    @objc
    private func didTapFollowButton() {
        delegate?.didTapFollow()
    }
    
    @objc
    private func didTapShareButton() {
        delegate?.didTapShare()
    }
}

// MARK: - Content Setting

extension FeedCardsTableViewCell {
    private func setCardContent(_ viewModel: FeedCardsViewModelProtocol) {
        setCardTitle(viewModel)
        setTagView(viewModel)
        setFollowingButton(viewModel)
        setDateLabel(viewModel)
    }
    
    private func setTagView(_ viewModel: FeedCardsViewModelProtocol) {
        tagView.backgroundColor = viewModel.setTagTypeColor()
        tagLabel.text = viewModel.setTagTypeText()
    }
    
    private func setCardTitle(_ viewModel: FeedCardsViewModelProtocol) {
        titleLabel.text = viewModel.setTitleText()
    }
    
    private func setFollowingButton(_ viewModel: FeedCardsViewModelProtocol) {
        if !viewModel.setIsFollowing() {
            followButton.removeFromSuperview()
        } else {
            setConstraintFollowButton()
        }
    }
    
    private func setStackViewImageCards(_ viewModel: FeedCardsViewModelProtocol) {
        if !self.imagesFetched {
            let imagesURL = viewModel.getImagesURL()
            for urlString in imagesURL {
                let image = UIImageView()
                image.setImage(imageUrl: urlString)
                image.layer.cornerRadius = 8
                image.contentMode = .scaleAspectFill
                image.clipsToBounds = true
                self.stackCardView.addArrangedSubview(image)
                self.imagesFetched = true
                self.layoutIfNeeded()
            }
        }
    }
    
    private func setDescriptionTextView(_ viewModel: FeedCardsViewModelProtocol) {
        if let descriptionText = viewModel.setDescription() {
            postDescriptionLabel.text = descriptionText
        }
    }
    
    private func setDateLabel(_ viewModel: FeedCardsViewModelProtocol) {
        dateLabel.text = viewModel.setFormatedData()
    }
}

// MARK: - Layout

extension FeedCardsTableViewCell {
    private func setLayout(_ viewModel: FeedCardsViewModelProtocol) {
        setConstraintContainerLayout()
        setConstraintTagView()
        setFollowingButton(viewModel)
        setConstraintTitleLabel()
        setStackViewImageCards(viewModel)
        setConstraintStackView()
        
        if viewModel.setDescription() != nil {
            setConstraintDateLabel(hasDescription: true)
            setConstraintPostDescriptionLabel()
            setDescriptionTextView(viewModel)
        } else {
            setConstraintDateLabel(hasDescription: false)
        }
        setConstraintShareButton()
    }
    
    private func setConstraintContainerLayout() {
        contentView.addSubview(shadowView)
        contentView.addSubview(containerView)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: shadowView.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: shadowView.bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: shadowView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: shadowView.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4)
        ])
    }
    
    private func setConstraintTagView() {
        containerView.addSubview(tagView)
        tagView.addSubview(tagLabel)
        
        NSLayoutConstraint.activate([
            tagView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            tagView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16)
            
        ])
        
        NSLayoutConstraint.activate([
            tagLabel.leadingAnchor.constraint(equalTo: tagView.leadingAnchor, constant: 4),
            tagLabel.trailingAnchor.constraint(equalTo: tagView.trailingAnchor, constant: -4),
            tagLabel.topAnchor.constraint(equalTo: tagView.topAnchor, constant: 4),
            tagLabel.bottomAnchor.constraint(equalTo: tagView.bottomAnchor, constant: -4)
        ])
    }
    
    private func setConstraintFollowButton() {
        containerView.addSubview(followButton)
        
        NSLayoutConstraint.activate([
            followButton.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            followButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
        ])
    }
    
    private func setConstraintTitleLabel() {
        containerView.addSubview(titleLabel)
        containerView.addSubview(separatorLine)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: tagView.bottomAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            separatorLine.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            separatorLine.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            separatorLine.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            separatorLine.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    private func setConstraintStackView() {
        containerView.addSubview(stackCardView)
        
        NSLayoutConstraint.activate([
            stackCardView.heightAnchor.constraint(equalToConstant: 100),
            stackCardView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            stackCardView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            stackCardView.topAnchor.constraint(equalTo: separatorLine.bottomAnchor, constant: 16)
        ])
    }
    
    private func setConstraintDateLabel(hasDescription: Bool) {
        containerView.addSubview(dateLabel)
        
        if hasDescription {
            NSLayoutConstraint.activate([
                dateLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
                dateLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16),
            ])
        } else {
            NSLayoutConstraint.activate([
                dateLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
                dateLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16),
                dateLabel.topAnchor.constraint(equalTo: stackCardView.bottomAnchor, constant: 16)
            ])
        }
        
    }
    
    private func setConstraintShareButton() {
        containerView.addSubview(shareButton)
        
        NSLayoutConstraint.activate([
            shareButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            shareButton.centerYAnchor.constraint(equalTo: dateLabel.centerYAnchor)
        ])
    }
    
    private func setConstraintPostDescriptionLabel() {
        containerView.addSubview(postDescriptionLine)
        containerView.addSubview(postDescriptionLabel)
        
        NSLayoutConstraint.activate([
            postDescriptionLine.topAnchor.constraint(equalTo: stackCardView.bottomAnchor, constant: 16),
            postDescriptionLine.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            postDescriptionLine.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            postDescriptionLine.heightAnchor.constraint(equalToConstant: 1)
        ])
        
        NSLayoutConstraint.activate([
            postDescriptionLabel.topAnchor.constraint(equalTo: postDescriptionLine.bottomAnchor, constant: 16),
            postDescriptionLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            postDescriptionLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            postDescriptionLabel.bottomAnchor.constraint(equalTo: dateLabel.topAnchor, constant: -24)
        ])
    }
}

