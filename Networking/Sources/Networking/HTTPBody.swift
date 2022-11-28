//
//  HTTPBody.swift
//  
//
//  Created by Victor Chirino on 21/10/2022.
//

import Foundation

public typealias HTTPBody = Encodable

extension HTTPBody {
    func encode(encoder: JSONEncoder) -> Data? {
        try? encoder.encode(self)
    }
}
