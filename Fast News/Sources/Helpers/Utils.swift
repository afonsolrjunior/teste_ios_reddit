//
//  Utils.swift
//  Fast News
//
//  Created by Afonso Lucas on 30/09/20.
//  Copyright © 2020 Lucas Moreton. All rights reserved.
//

import Foundation
import UIKit

class Utils {
    
    static func getIndexPaths<T>(for collection: [T], in tableView: UITableView) -> [IndexPath] {
        guard !collection.isEmpty else { return [IndexPath]() }
        
        var indexPaths = [IndexPath]()
        let numberOfCells = tableView.numberOfRows(inSection: 0)
        
        for i in numberOfCells..<collection.count {
            indexPaths.append(IndexPath(row: i, section: 0))
        }
        
        return indexPaths
    }
    
}


