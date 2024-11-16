//
//  AboutAppView.swift
//  SkyWizard-SwiftUI
//
//  Created by Hishara Dilshan on 16/11/2024.
//

import SwiftUI

struct AboutAppView: View {
    var body: some View {
        List {
            Section("Sources") {
                AboutAppListItem(
                    imageName: "cloud.sun.circle",
                    title: "Weather",
                    subtitle: "Open metro",
                    url: URL(string: "https://open-meteo.com")!
                )
                AboutAppListItem(
                    imageName: "location.circle",
                    title: "Geocoding",
                    subtitle: "Photon",
                    url: URL(string: "https://photon.komoot.io")!
                )
            }
            
            Section("About") {
                AboutAppListItem(
                    imageName: "info.circle",
                    title: "Version",
                    subtitle: Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String,
                    url: URL(string: "https://github.com/hishd/SkyWizard-SwiftUI")!
                )
                AboutAppListItem(
                    imageName: "folder.circle",
                    title: "Project Repository",
                    subtitle: "GitHub",
                    url: URL(string: "https://github.com/hishd/SkyWizard-SwiftUI")!
                )
            }
        }
        .navigationTitle("About App")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct AboutAppListItem: View {
    let imageName: String
    let title: String
    let subtitle: String?
    let url: URL
    
    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: imageName)
                .resizable()
                .frame(width: 28, height: 28)
            Text(title)
            Spacer()
            Text(subtitle ?? "")
            Link(destination: url) {
                Image(systemName: "link.circle")
                    .font(.title3)
            }

        }.padding(.vertical, 6)
    }
}

#Preview {
    NavigationStack {
        AboutAppView()
    }
}
