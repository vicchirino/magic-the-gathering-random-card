//
//  TextExtension.swift
//  magic-database
//
//  Created by Victor Chirino on 28/09/2022.
//

import SwiftUI

extension Text {
    func active(
        _ active: Bool,
        _ modifier: (Text) -> () -> Text
    ) -> Text {
        guard active else { return self }
        return modifier(self)()
    }
}
