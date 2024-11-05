//
//  StatePreviewWrapper.swift
//  SkyWizard-SwiftUI
//
//  Created by Hishara Dilshan on 05/11/2024.
//

import Foundation
import SwiftUI

#if DEBUG
struct StatePreviewWrapper<Value, Content: View>: View {
    @State var value: Value
    let content: (Binding<Value>) -> Content
    
    var body: some View {
        content($value)
    }
}
#endif
