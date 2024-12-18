//
//  GlassModifier.swift
//  SkyWizard-SwiftUI
//
//  Created by Hishara Dilshan on 03/11/2024.
//

import Foundation
import SwiftUI

struct GlassView: View {
    let cornerRadius: CGFloat
    let fill: Color
    let opacity: CGFloat
    let shadowRadius: CGFloat

    init(cornerRadius: CGFloat, fill: Color = .white, opacity: CGFloat = 0.05, shadowRadius: CGFloat = 5.0) {
        self.cornerRadius = cornerRadius
        self.fill = fill
        self.opacity = opacity
        self.shadowRadius = shadowRadius
    }

    var body: some View {
        Rectangle()
            .foregroundStyle(fill.opacity(opacity))
//            .background(.ultraThinMaterial)
            .clipShape(.rect(cornerRadius: cornerRadius))
            .shadow(color: .gray.opacity(0.4), radius: shadowRadius)
            .drawingGroup()
    }
}

struct GlassModifier: ViewModifier {
    let cornerRadius: CGFloat
    let fill: Color
    let opacity: CGFloat
    let shadowRadius: CGFloat

    func body(content: Content) -> some View {
        content
            .background {
                GlassView(cornerRadius: cornerRadius, fill: fill, opacity: opacity, shadowRadius: shadowRadius)
            }
    }
}

extension View {
    func glass(cornerRadius: CGFloat, fill: Color = .white, opacity: CGFloat = 0.25, shadowRadius: CGFloat = 10.0) -> some View {
        modifier(GlassModifier(cornerRadius: cornerRadius, fill: fill, opacity: opacity, shadowRadius: shadowRadius))
    }
}
