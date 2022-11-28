//
//  HTTPHeader.swift
//  
//
//  Created by Victor Chirino on 21/10/2022.
//

import Foundation

public struct HTTPHeader {
    public let name: String
    public let value: String
    
    public init(name: String, value: String) {
        self.name = name
        self.value = value
    }
}

// MARK: - Specific headers

public extension HTTPHeader {
    static func authorization(_ value: String) -> Self {
        .init(name: "Authorization", value: value)
    }

    static func contentType(_ value: String) -> Self {
        .init(name: "Content-Type", value: value)
    }

    static func userAgent(_ value: String) -> Self {
        .init(name: "User-Agent", value: value)
    }
}

// MARK: - Default headers

public extension HTTPHeader {
    static func bearerAuthorization(_ value: String) -> Self {
        .authorization("Bearer \(value)")
    }

    static let jsonContentType: Self = .contentType("application/json")

    static let defaultUserAgent: Self = {
        let info = Bundle.main.infoDictionary
        let osVersion = ProcessInfo.processInfo.operatingSystemVersion

        let executable = info?["CFBundleExecutable"] as? String ?? "Unknown"
        let version = info?["CFBundleShortVersionString"] as? String ?? "Unknown"
        let build = info?["CFBundleVersion"] as? String ?? "Unknown"
        let system = "macOS-\(osVersion.majorVersion).\(osVersion.minorVersion).\(osVersion.patchVersion)"

        let userAgent = executable + "-" + version + "(" + build + ")" + " " + system

        return .userAgent(userAgent)
    }()
}

