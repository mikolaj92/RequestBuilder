//
//  Encodable+JSONEncoder.swift
//  NetworkingProtocol
//
//  Created by patrykmikolajczyk on 1/25/19.
//  Copyright © 2019 mikolaj92. All rights reserved.
//

import Foundation

extension Encodable {
    var encoded: Data? {
        return try? JSONEncoder.current.encode(self)
    }
}
