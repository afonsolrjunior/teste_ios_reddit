//
//  FeedDetailsView.swift
//  Fast News
//
//  Copyright © 2019 Lucas Moreton. All rights reserved.
//

import UIKit

class FeedDetailsView: UIView {
    
    //MARK: - Constants
    private let feedCellHeight: CGFloat = 400.0
    private let commentCellHeight: CGFloat = 100.0
    
    private let feedCellReuseIdentifier = "FeedCell"
    private let commentCellReuseIdentifier = "CommentCell"
    
    //MARK: - Properties
    
    @IBOutlet weak var tableView: UITableView!
    private(set) var viewModels: [TypeProtocol] = [TypeProtocol]() {
        didSet {
            tableView.beginUpdates()
            tableView.insertRows(at: Utils.getIndexPaths(for: viewModels, in: tableView), with: .automatic)
            tableView.endUpdates()
        }
    }
    private var delegate: FeedViewDelegate?
    
    //MARK: - Public Methods
    
    func setup(with viewModels: [TypeProtocol], and delegate: FeedViewDelegate) {
        tableView.estimatedRowHeight = feedCellHeight
        tableView.rowHeight = UITableView.automaticDimension
        
        tableView.register(UINib(nibName: "FeedCell", bundle: Bundle.main),
                           forCellReuseIdentifier: feedCellReuseIdentifier)
        tableView.register(UINib(nibName: "CommentCell", bundle: Bundle.main),
                           forCellReuseIdentifier: commentCellReuseIdentifier)
        
        self.delegate = delegate
        tableView.delegate = self
        tableView.dataSource = self
        
        self.viewModels = viewModels
    }
    
    func updateViewModels(with viewModels: [TypeProtocol]) {
        self.viewModels = viewModels
    }
    
}

extension FeedDetailsView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let viewModel = viewModels[indexPath.row]
        
        switch viewModel.type {
        case .hotNews:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: feedCellReuseIdentifier, for: indexPath) as? FeedCell else { fatalError("Cell is not of type FeedCell!") }
            
            cell.setup(viewModel: viewModel)
            
            return cell
        case .comment:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: commentCellReuseIdentifier, for: indexPath) as? CommentCell else { fatalError("Cell is not of type CommentCell!") }
            
            cell.setup(viewModel: viewModel)
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch viewModels[indexPath.row].type {
        case .hotNews:
            return feedCellHeight
        default:
            return commentCellHeight
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewModel = viewModels[indexPath.row]
        
        switch viewModel.type {
        case .hotNews:
            guard let cell = tableView.cellForRow(at: indexPath) as? FeedCell else { fatalError("Cell is not of type FeedCell!") }
            
            delegate?.didTouch(cell: cell, indexPath: indexPath)
        case .comment:
            return
        }
    }
}
