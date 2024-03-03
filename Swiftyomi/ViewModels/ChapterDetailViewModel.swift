//
//  ChapterDetailViewModel.swift
//  Swiftyomi
//
//  Created by renyi on 2024/2/14.
//

import SwiftUI

class ChapterDetailViewModel: ObservableObject {
    @Published var chapter: MangaChapter = sampleChapter
    @Published var isLoading: Bool = false
    
    @MainActor
    func fetchChapterDatail(mangaId: Int, chapterIndex: Int) {
        self.isLoading = true
        print("fetch pageCount")
        guard let url = URL(string: "http://192.168.10.16:4567/api/v1/manga/\(mangaId)/chapter/\(chapterIndex)") else {
            print("Invalid URL")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching extensions: \(error)")
                return
            }
            
            guard let data = data else {
                print("No data received")
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode(MangaChapter.self, from: data)
                DispatchQueue.main.async {
                    self.chapter = decodedData
                    self.isLoading = false
                }
            } catch {
                print("Error decoding data: \(error)")
            }
        }.resume()
    }
}
