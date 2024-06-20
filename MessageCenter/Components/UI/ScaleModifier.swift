//
//  ScaleModifier.swift
//  MessageCenter
//
//  Created by Jay Muthialu on 6/19/24.
//

import SwiftUI

struct ScaleModifier: ViewModifier {
    var showView: Bool

    func body(content: Content) -> some View {
        content
            .scaleEffect(showView ? 1.0 : 0.1, anchor: .center)
            .opacity(showView ? 1.0 : 0.0)
    }
}
