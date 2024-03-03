//
//  MangaContextMenuView.swift
//  Swiftyomi
//
//  Created by renyi on 2024/2/15.
//

import SwiftUI

struct MangaContextMenuView: View {
    @ObservedObject var viewModel: LibraryViewModel = LibraryViewModel()
    let manga: Manga
    var body: some View {
        Button {
            
        } label: {
            Label("Share", systemImage: "square.and.arrow.up")
        }
        Button {
            
        } label: {
            Label("Download", systemImage: "arrow.down.app")
        }
        
        Divider()
        
        Button {
            manga.inLibrary ? deleteFromLibrary(mangaId: manga.id) : addToLibrary(mangaId: manga.id)
        } label: {
            HStack {
                Text("Delete from Library")
                Image(systemName: manga.inLibrary ? "heart.fill" : "heart")
            }
        }
    }
}
