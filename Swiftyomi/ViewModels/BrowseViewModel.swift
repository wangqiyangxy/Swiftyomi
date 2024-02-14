//
//  BrowseViewModel.swift
//  Swiftyomi
//
//  Created by renyi on 2024/2/12.
//

import Foundation

struct Extension: Decodable, Hashable {
    let iconUrl: String
    let name: String
    let versionName: String
    let versionCode: Int
    let lang: String
    let isNsfw: Bool
    let installed: Bool
    let hasUpdate: Bool
    let obsolete: Bool
}

struct Source: Decodable, Hashable {
    let id: String
    let name: String
    let lang: String
    let iconUrl: String
    let supportsLatest: Bool
    let isConfigurable: Bool
    let isNsfw: Bool
    let displayName: String
}

class BrowseViewModel: ObservableObject {
    @Published var sources = [Source]()
    @Published var extensions = [Extension]()
    @Published var isLoading: Bool = false
    
    @MainActor
    func fetchExtensions() {
        self.isLoading = true
        guard let url = URL(string: "http://127.0.0.1:4567/api/v1/extension/list") else {
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
                let decodedData = try JSONDecoder().decode([Extension].self, from: data)
                DispatchQueue.main.async {
                    self.extensions = decodedData.filter { $0.installed == false }
                    self.isLoading = false
                }
            } catch {
                print("Error decoding data: \(error)")
            }
        }.resume()
    }
    
    @MainActor
    func fetchSources() {
        self.isLoading = true
        guard let url = URL(string: "http://127.0.0.1:4567/api/v1/source/list") else {
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
                let decodedData = try JSONDecoder().decode([Source].self, from: data)
                DispatchQueue.main.async {
                    self.sources = decodedData
                    self.isLoading = false
                }
            } catch {
                print("Error decoding data: \(error)")
            }
        }.resume()
    }
}
