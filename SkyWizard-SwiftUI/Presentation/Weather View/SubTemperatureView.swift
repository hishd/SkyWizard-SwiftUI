//
//  SubTemperatureView.swift
//  SkyWizard-SwiftUI
//
//  Created by Hishara Dilshan on 05/11/2024.
//

import SwiftUI

struct SubTemperatureView: View {
    @Binding var temperature: Int
    
    var body: some View {
        HStack(alignment: .top, spacing: 2) {
            Text("\(temperature)")
                .font(.getFont(type: .medium, size: 18))
            Text("0")
                .font(.getFont(type: .medium, size: 10))
            Text("C")
                .font(.getFont(type: .medium, size: 14))
                .padding(.top, 3)
        }
    }
}
