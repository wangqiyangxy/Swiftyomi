//
//  SourceDetailViewModel.swift
//  Swiftyomi
//
//  Created by renyi on 2024/2/12.
//

import Foundation

class SourceDetailViewModel: ObservableObject {
    @Published var mangas: MangaList = MangaList(mangaList: [Manga](), hasNextPage: true)
    @Published var isLoading: Bool = false
    
    @MainActor
    func fetchMangas(sourceId: String, page: Int) {
        self.isLoading = true
        guard let url = URL(string: "http://192.168.10.16:4567/api/v1/source/\(sourceId)/popular/\(page)") else {
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
                let decodedData = try JSONDecoder().decode(MangaList.self, from: data)
                DispatchQueue.main.async {
//                    for manga in decodedData.mangaList {
//                        if !self.mangas.mangaList.contains(manga) {
//                            self.mangas.mangaList.append(manga)
//                        }
//                    }
                    self.mangas = decodedData
                    self.isLoading = false
                }
            } catch {
                print("Error decoding data: \(error)")
            }
        }.resume()
    }
}
