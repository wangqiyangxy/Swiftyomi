//
//  NavHostView.swift
//  Swiftyomi
//
//  Created by renyi on 2024/2/12.
//

import SwiftUI

struct NavHostView: View {
    @State private var visibility: NavigationSplitViewVisibility = .all
    @State private var selectedTab: Tab?
    
    
    var body: some View {
        if UIDevice.current.userInterfaceIdiom == .pad {
            NavigationSplitView(columnVisibility: $visibility) {
                VStack {
                    List(selection: $selectedTab) {
                        ForEach(Tab.allCases) { tab in
                            HStack {
                                tab.tabContent
                            }.tag(tab)
                        }
                    }
                    .navigationTitle("Swiftyomi")
                }
            } detail: {
                if let selectedTab {
                    NavigationStack {
                        selectedTab.tabDetail
                    }
                } else {
                    ContentUnavailableView {
                        Label("Empty Content", systemImage: "sidebar.left")
                    } description: {
                        Text("Choose a manga you want to read!")
                    }
                }
            }
            .navigationSplitViewStyle(.prominentDetail)
        } else {
            TabView(selection: $selectedTab) {
                LibraryView(selectedTab: .library)
                    .tag(Tab.library)
                    .tabItem { Tab.library.tabContent }
                BrowseView(selectedTab: .browse)
                    .tag(Tab.browse)
                    .tabItem { Tab.browse.tabContent }
                Text("Updates")
                    .tag(Tab.updates)
                    .tabItem { Tab.updates.tabContent }
                Text("Settings")
                    .tag(Tab.settings)
                    .tabItem { Tab.settings.tabContent }
            }
        }
    }
}

#Preview {
    NavHostView()
}
