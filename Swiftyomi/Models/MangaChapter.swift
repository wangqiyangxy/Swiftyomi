//
//  MangaChapter.swift
//  Swiftyomi
//
//  Created by renyi on 2024/2/14.
//

import SwiftUI

struct MangaChapter: Decodable, Hashable {
    let id: Int
    let url: String
    let name: String
    let uploadDate: Int
    let chapterNumber: Int
    let mangaId: Int
    let read: Bool
    let bookmarked: Bool
    let lastPageRead: Int
    let lastReadAt: Int
    let index: Int
    let fetchedAt: Int
    let realUrl: String
    let downloaded: Bool
    let pageCount: Int
    let chapterCount: Int
}
