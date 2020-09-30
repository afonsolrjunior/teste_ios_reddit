//
//  HotNewsProviderProtocol.swift
//  Fast News
//
//  Created by Afonso Lucas on 30/09/20.
//  Copyright © 2020 Lucas Moreton. All rights reserved.
//

import Foundation

protocol HotNewsProviderProtocol {
    var environment: Environment { get set }
    
    func hotNews(isInitialFetch: Bool, completion: @escaping HotNewsCallback)
    func hotNewsComments(id: String, completion: @escaping HotNewsCommentsCallback)
}
