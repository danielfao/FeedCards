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
    private var feedViewModel: [FeedCardsViewModelProtocol] = []
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Feed"

        navigationController?.view.backgroundColor = .lightGray
        setTableView()
        setDataSource()
    }
    
    // MARK: - Private functions
    
    private func setTableView() {
        tableView = UITableView(frame: .zero, style: .plain)
        tableView?.frame = view.bounds
        tableView?.backgroundColor = .lightGray
        tableView?.translatesAutoresizingMaskIntoConstraints = false
        tableView?.rowHeight = UITableView.automaticDimension
        tableView?.estimatedRowHeight = 100
        tableView?.register(FeedCardsTableViewCell.self, forCellReuseIdentifier: FeedCardsTableViewCell.identifier)
        tableView?.separatorStyle = .none
        tableView?.dataSource = self
        tableView?.delegate = self
        
        guard let tableView = tableView else {
            return
        }
        view.addSubview(tableView)
    }
    
    private func setDataSource() {
        let manager = FeedManager()
        manager.fetchData { [weak self] result, error in
            guard let self = self, let feedResult = result else {
                return
            }
            for feed in feedResult.feed {
                let viewModel = FeedCardsViewModel(feed)
                self.feedViewModel.append(viewModel)
            }
            self.tableView?.reloadData()
        }
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension FeedCardsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedViewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FeedCardsTableViewCell.identifier, for: indexPath) as? FeedCardsTableViewCell else {
            return UITableViewCell()
        }
        
        cell.setup(feedViewModel[indexPath.row])
        cell.delegate = self
        
        return cell
    }
}

// MARK: - FeedTableViewCellDelegate

extension FeedCardsViewController: FeedCardsTableViewCellDelegate {
    func didTapFollow() {
        print("Did tap Follow Button")
    }
    
    func didTapShare() {
        print("Did tap Share Button")
    }
}
