//
//  SubTemperatureView.swift
//  SkyWizard-SwiftUI
//
//  Created by Hishara Dilshan on 05/11/2024.
//

import SwiftUI

struct SubTemperatureView: View {
    var isHighTemp: Bool
    @Binding var temperature: Int
    
    var body: some View {
        HStack(alignment: .top, spacing: 2) {
            Text("\(isHighTemp ? "H" : "L") \(temperature)")
                .font(.getFont(type: .medium, size: 20))
                .padding(.top, 5)
            Text("0")
                .font(.getFont(type: .medium, size: 10))
        }
    }
}
