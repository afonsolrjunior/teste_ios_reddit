//
//  HotNewsProviderMock.swift
//  Fast News
//
//  Created by Afonso Lucas on 30/09/20.
//  Copyright © 2020 Lucas Moreton. All rights reserved.
//

import Foundation

class HotNewsProviderMock: HotNewsProviderProtocol {
    var environment: Environment = .testing(result: .success)
    static let shared: HotNewsProviderMock = HotNewsProviderMock()
    
    func hotNews(isInitialFetch: Bool, completion: @escaping HotNewsCallback) {
        switch environment {
        case .testing(let result):
            switch result {
            case .success:
                var hotNews = [HotNews]()
                
                for _ in 0..<5 {
                    hotNews.append(HotNews(id: nil, title: nil,
                                           preview: nil, url: nil,
                                           created: nil, ups: nil,
                                           downs: nil, score: nil,
                                           authorFullname: nil, numComments: nil))
                }
                
                completion { return hotNews }
                
            default:
                completion { throw NSError(domain: "Testing", code: 400, userInfo: nil) }
            }
        default:
            return
        }
    }
    
    func hotNewsComments(id: String, completion: @escaping HotNewsCommentsCallback) {
        switch environment {
        case .testing(let result):
            switch result {
            case .success:
                var comments = [Comment]()
                
                for _ in 0..<5 {
                    comments.append(Comment(created: nil, ups: nil, downs: nil, body: nil, authorFullname: nil))
                }
                
                completion { return comments }
            default:
                completion { throw NSError(domain: "Testing", code: 400, userInfo: nil) }
            }
        default:
            return
        }
    }
    
    
}
