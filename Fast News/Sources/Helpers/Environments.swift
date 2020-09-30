//
//  Environments.swift
//  Fast News
//
//  Created by Afonso Lucas on 30/09/20.
//  Copyright © 2020 Lucas Moreton. All rights reserved.
//

import Foundation

enum Environment {
    case testing(result: TestingResult)
    case normal
}

enum TestingResult {
    case success
    case fail
}
