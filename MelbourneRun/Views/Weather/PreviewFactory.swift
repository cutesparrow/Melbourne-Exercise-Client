//
//  PreviewGroup.swift
//  swift-weather-ui
//
//  Created by Guven Bolukbasi on 31.01.2020.
//  Copyright © 2020 dorianlabs. All rights reserved.
//

import SwiftUI

struct PreviewFactory<T: View> {

    static func previews(forView view: T) -> some View {
        
        return Group {
            
            // Pure View
            view
            .previewDisplayName("Pure")
            .previewLayout(.sizeThatFits)

            // Regular
            view
            .previewDisplayName("Simple")

            // Regular on SE
            view
            .previewDevice("iPhone SE")
            .previewDisplayName("iPhone SE")

            // Dark
            view
            .environment(\.colorScheme, .dark)
            .darkModeFix()
            .previewDisplayName("Dark mode")

            // XS
            view
            .environment(\.sizeCategory, .extraSmall)
            .previewDisplayName("XS Fonts")

            // XXL
            view
            .environment(\.sizeCategory,.accessibilityExtraExtraExtraLarge)
            .previewDisplayName("XXXXL Fonts")
            
            // Right to Left
            view
            .environment(\.layoutDirection, .rightToLeft)
            .previewDisplayName("Right to Left")
        }
    }
}

// MARK: Dark Mode Fix (Necessary for XCode 11.3.1 or before, might be obsolete later)

public struct DarkView<Content> : View where Content : View {
    var darkContent: Content
    var on: Bool
    public init(_ on: Bool, @ViewBuilder content: () -> Content) {
        self.darkContent = content()
        self.on = on
    }

    public var body: some View {
        ZStack {
            if on {
                Spacer()
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                    .background(Color.black)
                    .edgesIgnoringSafeArea(.all)
                darkContent.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity).background(Color.black).colorScheme(.dark)
            } else {
                darkContent
            }
        }
    }
}

extension View {
    public func darkModeFix(_ on: Bool = true) -> DarkView<Self> {
        DarkView(on) {
            self
        }
    }
}
