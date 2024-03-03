//
//  MangaCompactGridView.swift
//  Swiftyomi
//
//  Created by renyi on 2024/2/13.
//

import SwiftUI

struct MangaCompactGridView: View {
    let mangas: [Manga]
    let columns = [ GridItem(.adaptive(minimum: 100)) ]
    
    var body: some View {
        LazyVGrid(columns: columns) {
            ForEach(mangas, id: \.id) { manga in
                NavigationLink(destination: {
                    MangaDetailView(manga: manga)
                }, label: {
                    ZStack(alignment: .bottom) {
                        MangaCoverCellView(manga: manga)
                            .frame(minWidth: 100, minHeight: 150)
                        Text(manga.title)
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
                    #if os(iOS)
                    .contentShape(.contextMenuPreview, .rect(cornerRadius: 12))
                    #endif
                    .clipShape(.rect(cornerRadius: 12))
                    .shadow(color: .secondary.opacity(0.2), radius: 20)
                    .contextMenu {
                        MangaContextMenuView(manga: manga)
                    }
                })
            }
        }
        .padding()
    }
}
