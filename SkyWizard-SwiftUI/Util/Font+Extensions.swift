//
//  Font+Extensions.swift
//  SkyWizard-SwiftUI
//
//  Created by Hishara Dilshan on 03/11/2024.
//

import Foundation
import SwiftUI

extension Font {
    enum FontType {
        case black
        case bold
        case light
        case medium
        case regular
        case semibold
    }
    
    static func getFont(type: FontType, size: CGFloat) -> Font {
        switch type {
        case .black: .custom("Montserrat-Black", size: size)
        case .bold: .custom("Montserrat-Bold", size: size)
        case .light: .custom("Montserrat-Light", size: size)
        case .medium: .custom("Montserrat-Medium", size: size)
        case .regular: .custom("Montserrat-Regular", size: size)
        case .semibold: .custom("Montserrat-SemiBold", size: size)
        }
    }
}
