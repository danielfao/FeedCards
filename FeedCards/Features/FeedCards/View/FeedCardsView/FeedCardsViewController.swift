//
//  FeedCardsViewController.swift
//  FeedCards
//
//  Created by Daniel Oliveira on 09/12/21.
//

import UIKit

class FeedCardsViewController: UIViewController {
    
    // MARK: - Private properties
    
    private var tableView: UITableView?
    private var feedViewModel: FeedCardsViewModelProtocol
    
    // MARK: - Initializers
    
    init(feedViewModel: FeedCardsViewModelProtocol) {
        self.feedViewModel = feedViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = LocalizableStrings.feedTitle.localized

        setTableView()
        feedViewModel.fetchData()
    }
    
    // MARK: - Private functions
    
    private func setTableView() {
        tableView = UITableView(frame: .zero, style: .plain)
        tableView?.frame = view.bounds
        tableView?.backgroundColor = .lightGray
        tableView?.translatesAutoresizingMaskIntoConstraints = false
        tableView?.rowHeight = UITableView.automaticDimension
        tableView?.estimatedRowHeight = .size(.huge)
        tableView?.register(FeedCardsTableViewCell.self, forCellReuseIdentifier: FeedCardsTableViewCell.identifier)
        tableView?.separatorStyle = .none
        tableView?.dataSource = self
        tableView?.delegate = self
        
        guard let tableView = tableView else { return }
        view.addSubview(tableView)
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension FeedCardsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedViewModel.feed.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FeedCardsTableViewCell.identifier, for: indexPath) as? FeedCardsTableViewCell else {
            return UITableViewCell()
        }
        
        let model = FeedCardsModelViewCell(with: feedViewModel.feed[indexPath.row])
        cell.setup(model)
        cell.delegate = self
        
        return cell
    }
}

// MARK: - FeedTableViewCellDelegate

extension FeedCardsViewController: FeedCardsTableViewCellDelegate {
    // MARK: - Public functions
    
    func didTapImage(_ id: String) {
        print("Did tap on image with ID: \(id)")
        
        showAlertView(with: LocalizableStrings.alertImageTitle.localized, and: String(format: LocalizableStrings.alertImageMessage.localized, id))
    }
    
    func didTapFollow() {
        print("Did tap Follow Button")
        
        showAlertView(with: LocalizableStrings.alertFollowTitle.localized, and: LocalizableStrings.alertFollowMessage.localized)
    }
    
    func didTapShare() {
        print("Did tap Share Button")
        
        showAlertView(with: LocalizableStrings.alertShareTitle.localized, and: LocalizableStrings.alertShareMessage.localized)
    }
    
    // MARK: - Private functions
    
    private func showAlertView(with title: String, and message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: LocalizableStrings.ok.localized.uppercased(), style: .cancel))
        self.present(alert, animated: true)
    }
}
