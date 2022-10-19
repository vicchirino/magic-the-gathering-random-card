//
//  SwiftUIView.swift
//  
//
//  Created by Victor Chirino on 18/10/2022.
//

import SwiftUI

public struct MTGSetIconView: View {

    let set: String

    public init(set: String) {
        self.set = set
    }
    
    @available(iOS 13.0, *)
    public var body: some View {
        Image(set.lowercased(), bundle: Bundle.module)
            .resizable()
            .aspectRatio(contentMode: .fit)
    }
}

struct MTGSetIconView_Previews: PreviewProvider {
    @available(iOS 13.0, *)
    static var previews: some View {
        MTGSetIconView(set: "inv")
            .previewLayout(.fixed(width: 60, height: 60))
    }
}
