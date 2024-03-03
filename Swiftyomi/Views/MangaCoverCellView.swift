//
//  MangaCoverCellView.swift
//  Swiftyomi
//
//  Created by renyi on 2024/2/13.
//

import SwiftUI
import Kingfisher

struct MangaCoverCellView: View {
    let manga: Manga
    var body: some View {
        KFImage(URL(string: "http://192.168.10.16:4567\(manga.thumbnailUrl)"))
            .placeholder {
                ProgressView()
            }
            .resizable()
            .scaledToFit()
    }
}
