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
    func didTapImage(_ imageId: String)
}

class FeedCardsTableViewCell: UITableViewCell {
    
    // MARK: - Constants
    
    private let height: CGFloat = 100
    private let separatorLineHeight: CGFloat = 1
    private let numberOfLines: Int = 1
    private let shareIconImage: UIImage = UIImage(named: "share_icon") ?? UIImage()
    
    // MARK: - Identifier
    
    static let identifier = "FeedCardsTableViewCell"
    
    // MARK: - Delegate
    
    public weak var delegate: FeedCardsTableViewCellDelegate?
    
    // MARK: - Private properties
    
    private var feed: Feed?
    private var imagesFetched: Bool = false
    private var viewModel: FeedCardsViewModelCellProtocol?
    
    // MARK: - Private elements
    
    private lazy var containerView: UIView = {
        let containerView = UIView()
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = .size(.tine)
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
        tagView.layer.cornerRadius = .size(.tine)
        tagView.translatesAutoresizingMaskIntoConstraints = false
        
        return tagView
    }()
    
    private lazy var tagLabel: UILabel = {
        let tagLabel = UILabel()
        tagLabel.textColor = .white
        tagLabel.textAlignment = .center
        tagLabel.numberOfLines = numberOfLines
        tagLabel.font = .defaultRegularFont()
        tagLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return tagLabel
    }()
    
    private lazy var followButton: UIButton = {
        let followButton = UIButton()
        followButton.backgroundColor = .systemOrange
        followButton.titleLabel?.font = .defaultRegularFont()
        followButton.setTitle(LocalizableStrings.followButtonTitle.localized.uppercased(), for: .normal)
        followButton.contentEdgeInsets = UIEdgeInsets(top: .spacing(.xSmall), left: .spacing(.xSmall), bottom: .spacing(.xSmall), right: .spacing(.xSmall))
        followButton.layer.cornerRadius = .size(.tine)
        followButton.addTarget(self, action: #selector(didTapFollowButton), for: .touchUpInside)
        followButton.translatesAutoresizingMaskIntoConstraints = false
        
        return followButton
    }()
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.textColor = .black
        titleLabel.textAlignment = .natural
        titleLabel.numberOfLines = .zero
        titleLabel.font = .bigBoldFont()
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
        stackCardView.spacing = .spacing(.medium)
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
        postDescriptionLabel.font = .bigRegularFont()
        postDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return postDescriptionLabel
    }()
    
    private lazy var dateLabel: UILabel = {
        let dateLabel = UILabel()
        dateLabel.textColor = .lightGray
        dateLabel.numberOfLines = numberOfLines
        dateLabel.font = .defaultMediumFont()
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return dateLabel
    }()
    
    private lazy var shareButton: UIButton = {
        let shareButton = UIButton()
        shareButton.titleLabel?.font = .defaultSemiBoldFont()
        shareButton.setTitle(LocalizableStrings.shareButtonTitle.localized.uppercased(), for: .normal)
        shareButton.setTitleColor(.systemOrange, for: .normal)
        shareButton.setImage(shareIconImage, for: .normal)
        shareButton.imageView?.tintColor = .systemOrange
        shareButton.imageEdgeInsets = UIEdgeInsets(top: .zero, left: -.size(.small), bottom: .zero, right: .zero)
        shareButton.layer.cornerRadius = .size(.tine)
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
    
    public func setup(_ feed: Feed) {
        self.viewModel = FeedCardsViewModelCell(feed)
        setCardContent()
        setLayout()
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
    
    @objc
    private func didTapStackImageView(_ imageId: String) {
        delegate?.didTapImage(imageId)
    }
}

// MARK: - Content Setting

extension FeedCardsTableViewCell {
    private func setCardContent() {
        setTagView()
        setCardTitle()
        setFollowingButton()
        setDateLabel()
    }
    
    private func setTagView() {
        tagView.backgroundColor = viewModel?.getTagTypeColor()
        tagLabel.text = viewModel?.getTagTypeText()
    }
    
    private func setCardTitle() {
        titleLabel.text = viewModel?.getTitleText()
    }
    
    private func setFollowingButton() {
        if !(viewModel?.getIsFollowing() ?? false) {
            followButton.removeFromSuperview()
        } else {
            setConstraintFollowButton()
        }
    }
    
    private func setStackViewImageCards() {
        if !self.imagesFetched {
            guard let imagesUrl = viewModel?.getImagesURL() else { return }

            for urlString in imagesUrl {
                let image = UIImageView()
                image.setImage(imageUrl: urlString)
                image.layer.cornerRadius = .size(.xSmall)
                image.contentMode = .scaleAspectFill
                image.clipsToBounds = true
                self.stackCardView.addArrangedSubview(image)
                self.imagesFetched = true
                self.layoutIfNeeded()
            }
        }
    }
    
    private func setDescriptionTextView() {
        if let descriptionText = viewModel?.getDescription() {
            postDescriptionLabel.text = descriptionText
        }
    }
    
    private func setDateLabel() {
        dateLabel.text = viewModel?.getFormatedDate()
    }
}

// MARK: - Layout

extension FeedCardsTableViewCell {
    private func setLayout() {
        setConstraintContainerLayout()
        setConstraintTagView()
        setFollowingButton()
        setConstraintTitleLabel()
        setStackViewImageCards()
        setConstraintStackView()
        
        if viewModel?.getDescription() != nil {
            setConstraintDateLabel(hasDescription: true)
            setConstraintPostDescriptionLabel()
            setDescriptionTextView()
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
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: .size(.tine)),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: .size(.xSmall)),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -.size(.xSmall)),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -.size(.tine))
        ])
    }
    
    private func setConstraintTagView() {
        containerView.addSubview(tagView)
        tagView.addSubview(tagLabel)
        
        NSLayoutConstraint.activate([
            tagView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: .size(.medium)),
            tagView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: .size(.medium))
            
        ])
        
        NSLayoutConstraint.activate([
            tagLabel.leadingAnchor.constraint(equalTo: tagView.leadingAnchor, constant: .size(.tine)),
            tagLabel.trailingAnchor.constraint(equalTo: tagView.trailingAnchor, constant: -.size(.tine)),
            tagLabel.topAnchor.constraint(equalTo: tagView.topAnchor, constant: .size(.tine)),
            tagLabel.bottomAnchor.constraint(equalTo: tagView.bottomAnchor, constant: -.size(.tine))
        ])
    }
    
    private func setConstraintFollowButton() {
        containerView.addSubview(followButton)
        
        NSLayoutConstraint.activate([
            followButton.topAnchor.constraint(equalTo: containerView.topAnchor, constant: .size(.medium)),
            followButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -.size(.medium)),
        ])
    }
    
    private func setConstraintTitleLabel() {
        containerView.addSubview(titleLabel)
        containerView.addSubview(separatorLine)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: tagView.bottomAnchor, constant: .size(.medium)),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: .size(.medium)),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -.size(.medium))
        ])
        
        NSLayoutConstraint.activate([
            separatorLine.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: .size(.xSmall)),
            separatorLine.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            separatorLine.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            separatorLine.heightAnchor.constraint(equalToConstant: separatorLineHeight)
        ])
    }
    
    private func setConstraintStackView() {
        containerView.addSubview(stackCardView)
        
        NSLayoutConstraint.activate([
            stackCardView.heightAnchor.constraint(equalToConstant: height),
            stackCardView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: .size(.medium)),
            stackCardView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -.size(.medium)),
            stackCardView.topAnchor.constraint(equalTo: separatorLine.bottomAnchor, constant: .size(.medium))
        ])
    }
    
    private func setConstraintDateLabel(hasDescription: Bool) {
        containerView.addSubview(dateLabel)
        
        if hasDescription {
            NSLayoutConstraint.activate([
                dateLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: .size(.medium)),
                dateLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -.size(.medium)),
            ])
        } else {
            NSLayoutConstraint.activate([
                dateLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: .size(.medium)),
                dateLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -.size(.medium)),
                dateLabel.topAnchor.constraint(equalTo: stackCardView.bottomAnchor, constant: .size(.medium))
            ])
        }
        
    }
    
    private func setConstraintShareButton() {
        containerView.addSubview(shareButton)
        
        NSLayoutConstraint.activate([
            shareButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -.size(.medium)),
            shareButton.centerYAnchor.constraint(equalTo: dateLabel.centerYAnchor)
        ])
    }
    
    private func setConstraintPostDescriptionLabel() {
        containerView.addSubview(postDescriptionLine)
        containerView.addSubview(postDescriptionLabel)
        
        NSLayoutConstraint.activate([
            postDescriptionLine.topAnchor.constraint(equalTo: stackCardView.bottomAnchor, constant: .size(.medium)),
            postDescriptionLine.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            postDescriptionLine.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            postDescriptionLine.heightAnchor.constraint(equalToConstant: separatorLineHeight)
        ])
        
        NSLayoutConstraint.activate([
            postDescriptionLabel.topAnchor.constraint(equalTo: postDescriptionLine.bottomAnchor, constant: .size(.medium)),
            postDescriptionLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: .size(.medium)),
            postDescriptionLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -.size(.medium)),
            postDescriptionLabel.bottomAnchor.constraint(equalTo: dateLabel.topAnchor, constant: -.size(.big))
        ])
    }
}
