//
//  WeatherMessagePopup.swift
//  SkyWizard-SwiftUI
//
//  Created by Hishara Dilshan on 15/11/2024.
//

import SwiftUI

struct WeatherMessagePopup: View {
    let message: String
    @Binding var isPresent: Bool
    
    var body: some View {
        ZStack {
            ZStack {
                HStack(spacing: 14) {
                    Image(.wizardFace)
                        .resizable()
                        .frame(width: 60, height: 60)
                    Text(self.message)
                        .foregroundStyle(.daySubTitle)
                        .font(.getFont(type: .medium, size: 14))
                    Button {
                        withAnimation {
                            isPresent.toggle()
                        }
                    } label: {
                        Circle()
                            .foregroundStyle(.white)
                            .frame(width: 40, height: 40)
                            .overlay {
                                Image(systemName: "multiply")
                                    .foregroundStyle(.daySubTitle)
                            }
                    }
                    
                }
                .padding(.horizontal, 4)
            }
            .padding(8)
            .frame(maxWidth: .infinity)
            .background {
                RoundedRectangle(cornerRadius: 40)
                    .foregroundStyle(.white)
            }
            .padding(.bottom, 40)
            .padding(.horizontal, 36)
            .shadow(radius: 6)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
    }
}

fileprivate struct WeatherMessagePopupWrapper: View {
    @State var message = "Rain's embrace awaits, take your umbrella."
    @State var isPresent: Bool = true
    
    var body: some View {
        ZStack {
            Color.gray
            WeatherMessagePopup(message: message, isPresent: $isPresent)
                .opacity(isPresent ? 1 : 0)
        }

        .ignoresSafeArea()
    }
}

#Preview {
    WeatherMessagePopupWrapper()
}
