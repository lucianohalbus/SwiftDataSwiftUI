//Created by Halbus Development

import SwiftUI

struct HiddenModifier: ViewModifier {
    var isEnabled = false
    
    func body(content: Content) -> some View {
        if isEnabled {
            content
                .hidden()
        } else {
            content
        }
    }
}

extension View {
    func hidden(isEnabled: Bool) -> some View {
        modifier(HiddenModifier(isEnabled: isEnabled))
    }
}
