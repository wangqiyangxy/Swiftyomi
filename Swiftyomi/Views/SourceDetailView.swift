//
//  SourceDetailView.swift
//  Swiftyomi
//
//  Created by renyi on 2024/2/12.
//

import SwiftUI

struct SourceDetailView: View {
    @State private var searchText = ""
    @ObservedObject var viewModel = SourceDetailViewModel()
    let source: Source
    
    enum GridLayout: String, CaseIterable, Identifiable {
        case CompactGrid, ComfortableGrid, List
        var id: Self { self }
    }


    @State private var page = 1
    @State private var selectedGridLayout: GridLayout = .ComfortableGrid
    let offset: CGFloat = .zero
    
    var body: some View {
        NavigationStack {
            GeometryReader { geo in
                ScrollView {
                    LazyVStack {
                        if viewModel.isLoading {
                            ProgressView()
                        } else {
                            switch selectedGridLayout {
                            case .CompactGrid:
                                MangaCompactGridView(mangas: viewModel.mangas.mangaList)
                            case .ComfortableGrid:
                                MangaComfortableGridView(mangas: viewModel.mangas.mangaList)
                            case .List:
                                MangaListView(mangas: viewModel.mangas.mangaList)
                            }
                        }
                    }
                    .onChange(of: geo.frame(in: .global).origin.y) { oldValue, newValue in
                        print(newValue)
    //                        if newValue.origin.y + newValue.size.height >= geometry.size.height {
    //                            viewModel.fetchMangas(sourceId: source.id, page: page + 1)
    //                        }
                    }
                }
            }
            .navigationTitle(source.name)
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
            if viewModel.mangas.mangaList == [] {
                viewModel.fetchMangas(sourceId: source.id, page: page)
            }
        }
        .refreshable {
            viewModel.fetchMangas(sourceId: source.id, page: page)
        }

    }
}

#Preview {
    SourceDetailView(source: Source(id: "4341893737383682159", name: "古风漫画网", lang: "zh", iconUrl: "/api/v1/extension/icon/tachiyomi-zh.gufengmh-v1.4.16.apk", supportsLatest: true, isConfigurable: false, isNsfw: false, displayName: "古风漫画网 (ZH)"))
}
