//
//  SourceDetailView.swift
//  Swiftyomi
//
//  Created by renyi on 2024/2/12.
//

import SwiftUI

struct SourceDetailView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    SourceDetailView(source: Source(id: "4341893737383682159", name: "古风漫画网", lang: "zh", iconUrl: "/api/v1/extension/icon/tachiyomi-zh.gufengmh-v1.4.16.apk", supportsLatest: true, isConfigurable: false, isNsfw: false, displayName: "古风漫画网 (ZH)"))
}

struct MangaCoverCellView: View {
    let manga: Manga
    var body: some View {
        AsyncImage(url: URL(string: "http://192.168.10.16:4567\(manga.thumbnailUrl)")) { phase in
            if let image = phase.image {
                image // Displays the loaded image.
                    .resizable()
                    .scaledToFit()
            } else if phase.error != nil {
                Color.red // Indicates an error.
            } else {
                ProgressView("Loading")
            }
        }
    }
}

struct ComfortableGrid: View {
    let mangas: [Manga]
    let columns = [ GridItem(.adaptive(minimum: 150)) ]
    var body: some View {
        LazyVGrid(columns: columns) {
            ForEach(mangas, id: \.id) { manga in
                NavigationLink(destination: {
                    MangaDetailView(manga: manga)
                }, label: {
                    VStack(alignment: .leading) {
                        MangaCoverCellView(manga: manga)
                            .contentShape(.contextMenuPreview, .rect(cornerRadius: 12))
                            .clipShape(.rect(cornerRadius: 12))
                            .shadow(color: .secondary.opacity(0.2), radius: 20)
                            .contextMenu {
                                Button {
                                    
                                } label: {
                                    Label("分享", systemImage: "square.and.arrow.up")
                                }
                                Button {
                                    
                                } label: {
                                    Label("下载", systemImage: "arrow.down.app")
                                }
                                Divider()
                                if !manga.inLibrary {
                                    Button(role: .destructive) {
                                        //                                                addToLibrary(mangaId: mangaId)
                                    } label: {
                                        HStack {
                                            Text("Add to Library")
                                            Image(systemName: "heart")
                                                .foregroundColor(.red)
                                        }
                                    }
                                } else {
                                    Button(role: .destructive) {
                                        //                                                deleteFromLibrary(mangaId: mangaId)
                                    } label: {
                                        HStack {
                                            Text("Delete from Library")
                                            Image(systemName: "heart.fill")
                                                .foregroundColor(.red)
                                        }
                                    }
                                }
                            }
                        Text(manga.title)
                            .foregroundStyle(Color(uiColor: UIColor.label))
                            .font(.title3)
                            .bold()
                            .lineLimit(1)
                    }
                })
            }
        }
        .padding()
    }
}

struct CompactGrid: View {
    let mangas: [Manga]
    let columns = [ GridItem(.adaptive(minimum: 150)) ]
    
    var body: some View {
        LazyVGrid(columns: columns) {
            ForEach(mangas, id: \.id) { manga in
                ZStack(alignment: .bottom) {
                    MangaCoverCellView(manga: manga)
                    Text(manga.title)
                        .font(.title2)
                        .bold()
                        .frame(maxWidth: .infinity, maxHeight: 40)
                        .foregroundStyle(.white)
                        .background(RoundedRectangle(cornerRadius: 12).fill(
                            LinearGradient(
                                gradient: Gradient(colors: [.black, .clear]),
                                startPoint: .bottom,
                                endPoint: .top
                            )
                        ))
                        .lineLimit(1)
                }
                .contentShape(.contextMenuPreview, .rect(cornerRadius: 12))
                .clipShape(.rect(cornerRadius: 12))
                .shadow(color: .secondary.opacity(0.2), radius: 20)
                .contextMenu {
                    Button {
                        
                    } label: {
                        Label("分享", systemImage: "square.and.arrow.up")
                    }
                    Button {
                        
                    } label: {
                        Label("下载", systemImage: "arrow.down.app")
                    }
                    Divider()
                    if !manga.inLibrary {
                        Button(role: .destructive) {
                            //                                                addToLibrary(mangaId: mangaId)
                        } label: {
                            HStack {
                                Text("Add to Library")
                                Image(systemName: "heart")
                                    .foregroundColor(.red)
                            }
                        }
                    } else {
                        Button(role: .destructive) {
                            //                                                deleteFromLibrary(mangaId: mangaId)
                        } label: {
                            HStack {
                                Text("Delete from Library")
                                Image(systemName: "heart.fill")
                                    .foregroundColor(.red)
                            }
                        }
                    }
                }
            }
        }
        .padding()
    }
}

struct ListGrid: View {
    let mangas: [Manga]
    
    var body: some View {
        ForEach(mangas, id: \.id) { manga in
            HStack(alignment: .top) {
                MangaCoverCellView(manga: manga)
                    .clipShape(.rect(cornerRadius: 12))
                    .frame(maxWidth: 56, maxHeight: 56)
                VStack(alignment: .leading) {
                    Text(manga.title)
                        .font(.headline)
                        .bold()
                    Text("Author: \(manga.author ?? "Unknown")" )
                        .font(.callout)
                        .fontWeight(.light)
                    Text("Status: \(manga.status.lowercased())")
                        .font(.caption)
                        .fontWeight(.light)
                }
                Spacer()
            }
            .contentShape(.contextMenuPreview, .rect(cornerRadius: 12))
            .contextMenu {
                Button {
                    
                } label: {
                    Label("分享", systemImage: "square.and.arrow.up")
                }
                Button {
                    
                } label: {
                    Label("下载", systemImage: "arrow.down.app")
                }
                Divider()
                if !manga.inLibrary {
                    Button(role: .destructive) {
                        //                                                addToLibrary(mangaId: mangaId)
                    } label: {
                        HStack {
                            Text("Add to Library")
                            Image(systemName: "heart")
                                .foregroundColor(.red)
                        }
                    }
                } else {
                    Button(role: .destructive) {
                        //                                                deleteFromLibrary(mangaId: mangaId)
                    } label: {
                        HStack {
                            Text("Delete from Library")
                            Image(systemName: "heart.fill")
                                .foregroundColor(.red)
                        }
                    }
                }
            }
        }
        .padding()
    }
}
