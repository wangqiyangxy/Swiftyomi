//
//  Helpers.swift
//  Swiftyomi
//
//  Created by renyi on 2024/2/15.
//

import Foundation

func makeHttpRequest(method: String, url: URL) {
    var requset = URLRequest(url: url)
    requset.httpMethod = method
    
    let task = URLSession.shared.dataTask(with: requset) { _, _, _ in
    }
    task.resume()
}

func addToLibrary(mangaId: Int) {
    guard let url = URL(string: "http://192.168.10.16:4567/api/v1/manga/\(mangaId)/library/") else { fatalError("Missing URL") }
    
    makeHttpRequest(method: "GET", url: url)
}

func deleteFromLibrary(mangaId: Int) {
    guard let url = URL(string: "http://192.168.10.16:4567/api/v1/manga/\(mangaId)/library/") else { fatalError("Missing URL") }
    
    makeHttpRequest(method: "DELETE", url: url)
}
