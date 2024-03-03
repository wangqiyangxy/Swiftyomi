//
//  LibraryViewModel.swift
//  Swiftyomi
//
//  Created by renyi on 2024/2/14.
//

import SwiftUI

class LibraryViewModel: ObservableObject {
    @Published var categoryList: [MangaCategory] = [MangaCategory]()
    @Published var mangas: [Manga] = [Manga]()
    @Published var isLoading: Bool = false
    
    @MainActor
    func fetchMangaCategory() {
        self.isLoading = true
        print("fetch pageCount")
        guard let url = URL(string: "http://192.168.10.16:4567/api/v1/category") else {
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
                let decodedData = try JSONDecoder().decode([MangaCategory].self, from: data)
                DispatchQueue.main.async {
                    self.categoryList = decodedData
                    self.isLoading = false
                }
            } catch {
                print("Error decoding data: \(error)")
            }
        }.resume()
    }
    
    @MainActor
    func fetchLibraryManga(categoryId: Int) {
        self.isLoading = true
        print("fetch pageCount")
        guard let url = URL(string: "http://192.168.10.16:4567/api/v1/category/\(categoryId)") else {
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
                let decodedData = try JSONDecoder().decode([Manga].self, from: data)
                DispatchQueue.main.async {
                    self.mangas = decodedData
                    self.isLoading = false
                }
            } catch {
                print("Error decoding data: \(error)")
            }
        }.resume()
    }
}
