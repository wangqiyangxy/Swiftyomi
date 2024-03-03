//
//  MangaComfortableGridView.swift
//  Swiftyomi
//
//  Created by renyi on 2024/2/13.
//

import SwiftUI

struct MangaComfortableGridView: View {
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
                            .frame(minWidth: 150, minHeight: 220)
                        #if os(iOS)
                            .contentShape(.contextMenuPreview, .rect(cornerRadius: 12))
                        #endif
                            .clipShape(.rect(cornerRadius: 12))
                            .shadow(color: .secondary.opacity(0.2), radius: 20)
                            .contextMenu {
                                MangaContextMenuView(manga: manga)
                            }
                        Text(manga.title)
                        #if os(iOS)
                            .foregroundStyle(Color(uiColor: UIColor.label))
                        #endif
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
