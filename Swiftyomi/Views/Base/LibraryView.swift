//
//  LibraryView.swift
//  Swiftyomi
//
//  Created by renyi on 2024/2/13.
//

import SwiftUI

struct LibraryView: View {
    let selectedTab: Tab
    enum GridLayout: String, CaseIterable, Identifiable {
        case CompactGrid, ComfortableGrid, List
        var id: Self { self }
    }
    
    @State private var searchText = ""
    @State private var mangaCategoryList: [MangaCategory] = []
    @State private var selectedMangaCategoryId = 2
    @State private var selectedGridLayout: GridLayout = .ComfortableGrid
    
    @ObservedObject var viewModel = LibraryViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                Picker("", selection: $selectedMangaCategoryId) {
                    ForEach(viewModel.categoryList, id: \.id) { category in
                        Text(category.name).tag(category)
                    }
                }
                .onChange(of: selectedMangaCategoryId) {
                    viewModel.fetchLibraryManga(categoryId: selectedMangaCategoryId)
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)
                
                LazyVStack {
                    if viewModel.isLoading {
                        ProgressView("Loading")
                    } else {
                        switch selectedGridLayout {
                        case .CompactGrid:
                            MangaCompactGridView(mangas: viewModel.mangas)
                        case .ComfortableGrid:
                            MangaComfortableGridView(mangas: viewModel.mangas)
                        case .List:
                            MangaListView(mangas: viewModel.mangas)
                        }
                    }
                }
            }
            .navigationTitle(selectedTab.rawValue)
            .searchable(text: $searchText)
            .toolbar {
                Menu {
                    Picker("Grid", selection: $selectedGridLayout) {
                        Text("Compact Grid").tag(GridLayout.CompactGrid)
                        Text("Comfortable Grid").tag(GridLayout.ComfortableGrid)
                        Text("List").tag(GridLayout.List)
                    }
                } label: {
                    Label("Grid", systemImage: "square.grid.2x2")
                }
            }
        }
        .onAppear {
            viewModel.fetchMangaCategory()
            viewModel.fetchLibraryManga(categoryId: selectedMangaCategoryId)
        }
        .refreshable {
            viewModel.fetchLibraryManga(categoryId: selectedMangaCategoryId)
        }
    }
}

#Preview {
    LibraryView(selectedTab: .library)
}
