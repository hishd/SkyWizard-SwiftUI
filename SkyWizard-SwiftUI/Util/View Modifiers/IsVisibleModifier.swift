//
//  IsVisibleModifier.swift
//  SkyWizard-SwiftUI
//
//  Created by Hishara Dilshan on 06/11/2024.
//

import Foundation
import SwiftUI

struct IsVisibleModifier : ViewModifier{
    var isVisible : Bool
    var transition : AnyTransition

    func body(content: Content) -> some View {
        ZStack{
            if isVisible{
                content
                    .transition(transition)
            }
        }
    }
}

extension View {

    func isVisible(
        isVisible : Bool,
        transition : AnyTransition = .scale
    ) -> some View{
        modifier(
            IsVisibleModifier(
                isVisible: isVisible,
                transition: transition
            )
        )
    }
}
