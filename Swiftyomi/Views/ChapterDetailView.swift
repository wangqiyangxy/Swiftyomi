//
//  ChapterDetailView.swift
//  Swiftyomi
//
//  Created by renyi on 2024/2/14.
//

import SwiftUI
import Kingfisher

struct ChapterDetailView: View {
    var chapter: MangaChapter
    let viewModel: ChapterDetailViewModel
    enum ImageLayout: String, CaseIterable, Identifiable {
        case webton, vertical, horizontal
        var id: Self { self }
    }
    
    @State private var showNavigationBar = false
    @State private var showChapterList = false
    @State private var selectedImageLayout: ImageLayout = .horizontal
    var body: some View {
        NavigationStack {
            ScrollView {
                if viewModel.isLoading {
                    ProgressView()
                } else {
                    switch selectedImageLayout {
                    case .webton:
                        LazyVStack(spacing: 0) {
                            ForEach(0..<viewModel.chapter.pageCount, id: \.self) { index in
                                KFImage(URL(string: "http://192.168.10.16:4567/api/v1/manga/\(chapter.mangaId)/chapter/\(chapter.index)/page/\(index)"))
                                    .placeholder {
                                        ProgressView()
                                    }
                                    .resizable()
                                    .scaledToFit()
                            }
                        }
                    case .vertical:
                        LazyVStack {
                            ForEach(0..<viewModel.chapter.pageCount, id: \.self) { index in
                                KFImage(URL(string: "http://192.168.10.16:4567/api/v1/manga/\(chapter.mangaId)/chapter/\(chapter.index)/page/\(index)"))
                                    .placeholder {
                                        ProgressView()
                                    }
                                    .resizable()
                                    .scaledToFit()
                            }
                        }
                    case .horizontal:
                        HorizontalImageView(chapter: chapter)
                    }
                }
            }
//            .ignoresSafeArea()
            .onTapGesture {
                withAnimation(.easeIn) {
                    showNavigationBar.toggle()
                }
            }
            .navigationTitle(viewModel.chapter.name)
            #if os(iOS)
            .navigationBarTitleDisplayMode(.inline)
//            .navigationBarHidden(!showNavigationBar)
            #endif
            .toolbar {
                ToolbarItemGroup {
                    Button {
                        withAnimation(.smooth) {
                            showChapterList.toggle()
                        }
                    } label: {
                        Label("Content", systemImage: "list.bullet")
                    }
                    Menu {
                        Picker("Grid", selection: $selectedImageLayout) {
                            Text("Webton").tag(ImageLayout.webton)
                            Text("Vertical").tag(ImageLayout.vertical)
                            Text("Horizontal").tag(ImageLayout.horizontal)
                        }
                    } label: {
                        Label("Grid", systemImage: "square.grid.2x2")
                    }
                }
            }
            .sheet(isPresented: $showChapterList, content: {
                List {
//                    ForEach()
                }
            })
        }
        .onAppear {
            viewModel.fetchChapterDatail(mangaId: chapter.mangaId, chapterIndex: chapter.index)
        }
    }
}

#Preview {
    ChapterDetailView(chapter: sampleChapter, viewModel: ChapterDetailViewModel())
}

struct HorizontalImageView: View {
    let chapter: MangaChapter
    @State private var index: Int = 0
    @State private var isThresholdExceeded = false
    
    var body: some View {
        VStack {
            Spacer()
            
            KFImage(URL(string: "http://192.168.10.16:4567/api/v1/manga/\(chapter.mangaId)/chapter/\(chapter.index)/page/\(index)"))
                .placeholder {
                    ProgressView()
                }
                .resizable()
                .scaledToFit()
            
            Spacer()
        }
        .gesture(
            DragGesture(minimumDistance: 100)
                .onChanged { value in
                    
                    if !isThresholdExceeded {
                        if value.translation.width >= 100 && index > 0 {
                            index -= 1
                            isThresholdExceeded = true
                        } else if value.translation.width <= -100 && index < chapter.pageCount {
                            index += 1
                            isThresholdExceeded = true
                        } else {
                            isThresholdExceeded = false
                        }
                    }
                }
                .onEnded { _ in
                    // 拖动结束时重置阈值状态
                    isThresholdExceeded = false
                }
        )
    }
}
