//
//  Manga.swift
//  Swiftyomi
//
//  Created by renyi on 2024/2/13.
//

import SwiftUI

struct MangaList: Decodable {
    var mangaList: [Manga]
    var hasNextPage: Bool
}

struct Manga: Codable, Identifiable, Hashable, Comparable {
    static func < (lhs: Manga, rhs: Manga) -> Bool {
        lhs.title > rhs.title
    }
    
    let id: Int
    let sourceId: String
    let url: String
    let title: String
    let thumbnailUrl: String
    let thumbnailUrlLastFetched: Int
    let initialized: Bool
    let artist: String?
    let author: String?
    let description: String?
    let genre: [String]?
    let status: String
    let inLibrary: Bool
    let inLibraryAt: Int
    let source: String?
    let meta: [String:String]?
    let realUrl: String?
    let lastFetchedAt: Int
    let chaptersLastFetchedAt: Int
    let updateStrategy: String
    let freshData: Bool
    let unreadCount: Int?
    let downloadCount: Int?
    let chapterCount: Int?
    let lastChapterRead: Int?
    let age: Int
    let chaptersAge: Int
}
