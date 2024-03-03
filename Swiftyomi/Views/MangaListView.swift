//
//  MangaListView.swift
//  Swiftyomi
//
//  Created by renyi on 2024/2/13.
//

import SwiftUI

struct MangaListView: View {
    let mangas: [Manga]
    
    var body: some View {
        ForEach(mangas, id: \.id) { manga in
            NavigationLink(destination: {
                MangaDetailView(manga: manga)
            }, label: {
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
#if os(iOS)
                .contentShape(.contextMenuPreview, .rect(cornerRadius: 12))
                .contextMenu {
                    Button {
                        
                    } label: {
                        Label("Share", systemImage: "square.and.arrow.up")
                    }
                    Button {
                        
                    } label: {
                        Label("Download", systemImage: "arrow.down.app")
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
                .foregroundStyle(Color(uiColor: .label))
#endif
            })
        }
        .padding()
    }
}
