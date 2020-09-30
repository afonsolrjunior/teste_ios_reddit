//
//  FeedViewController.swift
//  Fast News
//
//  Copyright © 2019 Lucas Moreton. All rights reserved.
//

import Foundation
import UIKit

class FeedViewController: UIViewController {
    
    //MARK: - Constants
    
    let kToDetails: String = "toDetails"
    
    //MARK: - Properties
    
    private var initialLoad = true
    var hotNewsProvider: HotNewsProviderProtocol = HotNewsProvider.shared
    
    var hotNews: [HotNews] = [HotNews]() {
        didSet {
            var viewModels: [HotNewsViewModel] = [HotNewsViewModel]()
            _ = hotNews.map { (news) in
                viewModels.append(HotNewsViewModel(hotNews: news))
            }
            if initialLoad {
                initialLoad = false
                self.mainView.setup(with: viewModels, delegate: self, and: self)
            } else {
                self.mainView.updateViewModels(with: viewModels)
            }
        }
    }
    
    var mainView: FeedView {
        guard let view = self.view as? FeedView else {
            fatalError("View is not of type FeedView!")
        }
        return view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Fast News"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        self.fetchHotNews()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let hotNewsViewModel = sender as? HotNewsViewModel else { return }
        guard let detailViewController = segue.destination as? FeedDetailsViewController else { return }
        
        detailViewController.hotNewsViewModel = hotNewsViewModel
    }
}

extension FeedViewController: FeedViewDelegate {
    func didTouch(cell: FeedCell, indexPath: IndexPath) {
        self.performSegue(withIdentifier: kToDetails, sender: self.mainView.viewModels[indexPath.row])
    }
}

extension FeedViewController: UpdateDataDelegate {
    func updateData() {
        self.fetchHotNews()
    }
}

extension FeedViewController {
    private func fetchHotNews() {
        self.hotNewsProvider.hotNews(isInitialFetch: initialLoad) { (completion) in
            do {
                let hotNews = try completion()
                if self.initialLoad {
                    self.hotNews = hotNews
                } else {
                    self.hotNews.append(contentsOf: hotNews)
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
