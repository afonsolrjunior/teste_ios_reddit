//
//  FeedView.swift
//  Fast News
//
//  Copyright © 2019 Lucas Moreton. All rights reserved.
//

import UIKit

protocol FeedViewDelegate {
    func didTouch(cell: FeedCell, indexPath: IndexPath)
}

protocol UpdateDataDelegate {
    func updateData()
}

class FeedView: UIView {
    
    //MARK: - Constants
    private let cellHeight: CGFloat = 260.0
    private let reuseIdentifier = "FeedCell"
    
    //MARK: - Properties
    
    @IBOutlet weak var tableView: UITableView!
    private(set) var viewModels: [HotNewsViewModel] = [HotNewsViewModel]() {
        didSet {
            tableView.beginUpdates()
            tableView.insertRows(at: Utils.getIndexPaths(for: viewModels, in: tableView), with: .automatic)
            tableView.endUpdates()
        }
        
    }
    private var delegate: FeedViewDelegate?
    private var dataDelegate: UpdateDataDelegate?
    
    private var isLoading = false
    
    //MARK: - Public Methods
    
    func setup(with viewModels: [HotNewsViewModel], delegate: FeedViewDelegate, and updateDataDelegate: UpdateDataDelegate) {
        tableView.estimatedRowHeight = cellHeight
        tableView.rowHeight = UITableView.automaticDimension
        
        tableView.register(UINib(nibName: "FeedCell", bundle: Bundle.main), forCellReuseIdentifier: reuseIdentifier)
        
        self.delegate = delegate
        self.dataDelegate = updateDataDelegate
        tableView.delegate = self
        tableView.dataSource = self
        
        self.viewModels = viewModels
    }
    
    func updateViewModels(with viewModels: [HotNewsViewModel]) {
        self.viewModels = viewModels
    }
    
}

extension FeedView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? FeedCell else { fatalError("Cell is not of type FeedCell!") }
        
        cell.setup(hotNewsViewModel: viewModels[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? FeedCell else { fatalError("Cell is not of type FeedCell!") }
        
        delegate?.didTouch(cell: cell, indexPath: indexPath)
    }
}

extension FeedView: UIScrollViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.isLoading = false
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if (tableView.contentOffset.y + tableView.frame.size.height) >= tableView.contentSize.height {
            if !isLoading {
                isLoading = true
                self.dataDelegate?.updateData()
            }
        }
    }
    
}
