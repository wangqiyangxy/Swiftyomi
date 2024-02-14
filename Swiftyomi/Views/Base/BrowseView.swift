//
//  BrowseView.swift
//  Swiftyomi
//
//  Created by renyi on 2024/2/12.
//

import SwiftUI

struct BrowseView: View {
    let selectedTab: Tab
    let langs = ["all", "ar", "bg", "ca", "cs", "de", "en", "es", "fr", "hi", "id", "it", "ja", "ko", "pl", "pt-BR", "ru", "th", "tr", "uk", "vi", "zh", "zh-Hans"]
    
    var langFilteredExtensions: [Extension] {
        if selectedLang == "all" {
            return viewModel.extensions
        } else {
            return viewModel.extensions.filter { $0.lang == selectedLang }
        }
    }
    
    var langFilteredSources: [Source] {
        if selectedLang == "all" {
            return viewModel.sources
        } else {
            return viewModel.sources.filter { $0.lang == selectedLang }
        }
    }
    
    @State private var searchText = ""
    @State var browseList = ["Source", "Extension"]
    @State private var selectedBrowseItem = "Source"
    @State private var selectedLang = "zh"
    @ObservedObject var viewModel = BrowseViewModel()
    
    var body: some View {
        NavigationStack {
            Picker("", selection: $selectedBrowseItem) {
                ForEach(browseList, id: \.self) { item in
                    Text(item)
                }
            }
            .onChange(of: selectedBrowseItem) {
                
            }
            .pickerStyle(.segmented)
            .padding(.horizontal)
            
            if selectedBrowseItem == "Source" {
                List {
                    Section {
                        ForEach(langFilteredSources, id: \.self) { source in
                            NavigationLink(destination: {
                                SourceDetailView(source: source)
                            }, label: {
                                HStack {
                                    Text(source.displayName)
                                    Spacer()
                                    if source.supportsLatest {
                                        Button {
                                            
                                        } label: {
                                            Text("Latest")
                                        }
                                        .buttonStyle(.bordered)
                                    }
                                }
                            })
                        }
                    } header: {
                        Text(selectedLang)
                            .bold()
                    }
                }
                .onAppear {
                    if viewModel.sources.isEmpty {
                        viewModel.fetchSources()
                    }
                }
            } else {
                List {
                    Section {
                        ForEach(langFilteredExtensions, id: \.self) { item in
                            HStack {
                                Text(item.name)
                                Spacer()
                                Button {
                                    
                                } label: {
                                    Text("Install")
                                }
                                .buttonStyle(.bordered)
                            }
                        }
                    } header: {
                        Text(selectedLang)
                            .bold()
                    }
                }
                .onAppear {
                    if viewModel.extensions.isEmpty {
                        viewModel.fetchExtensions()
                    }
                }
            }
        }
        .background(Color(uiColor: .systemGray6))
        .navigationTitle(selectedTab.rawValue)
        .searchable(text: $searchText, prompt: "Search source")
        .toolbar {
            ToolbarItem {
                Menu {
                    Menu {
                        Picker("Language", selection: $selectedLang) {
                            ForEach(langs, id: \.self) {
                                Text($0)
                            }
                        }
                    } label: {
                        Label("Language", systemImage: "globe.americas")
                    }
                    
                } label: {
                    Label("Menu", systemImage: "line.3.horizontal.decrease.circle")
                }
            }
        }
        .onAppear {
            if viewModel.sources.isEmpty {
                viewModel.fetchSources()
            }
        }
    }
}

#Preview {
    NavigationStack {
        BrowseView(selectedTab: .browse)
    }
}
