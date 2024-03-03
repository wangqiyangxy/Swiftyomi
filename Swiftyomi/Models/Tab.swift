//
//  Tab.swift
//  Swiftyomi
//
//  Created by renyi on 2024/2/12.
//

import SwiftUI

enum Tab: String, CaseIterable, Identifiable {
    var id: String {
        rawValue
    }
    
    case browse = "Browse"
    case library = "Library"
    case updates = "Updates"
    case settings = "Settings"
    
    @ViewBuilder
    var tabContent: some View {
        switch self {
        case .browse:
            Image(systemName: "safari")
            Text(self.rawValue)
        case .library:
            Image(systemName: "books.vertical")
            Text(self.rawValue)
        case .updates:
            Image(systemName: "clock")
            Text(self.rawValue)
        case .settings:
            Image(systemName: "gear")
            Text(self.rawValue)
        }
    }
    
    @ViewBuilder
    var tabDetail: some View {
        switch self {
        case .browse:
            BrowseView(selectedTab: .browse)
        case .library:
            LibraryView(selectedTab: .library)
        case .updates:
            Text("Updates")
        case .settings:
            Text("Settings")
        }
    }
}
