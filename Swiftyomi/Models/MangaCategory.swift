//
//  MangaCategory.swift
//  Swiftyomi
//
//  Created by renyi on 2024/2/13.
//

import SwiftUI

struct MangaCategory: Decodable, Hashable {
    let id: Int
    let order: Int
    let name: String
    let defaultCategory: Bool
    let size: Int
    let includeInUpdate: Int
    let includeInDownload: Int
    
//    let meta: [String: Any] // Use [String: Any] to represent arbitrary metadata
    // Custom decoding keys to handle any special cases, such as 'default'
    private enum CodingKeys: String, CodingKey {
        case id, order, name, size, includeInUpdate, includeInDownload, meta
        case defaultCategory = "default"
    }
    // Implement the init(from:) initializer
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        // Decode each property
        self.id = try container.decode(Int.self, forKey: .id)
        self.order = try container.decode(Int.self, forKey: .order)
        self.name = try container.decode(String.self, forKey: .name)
        self.defaultCategory = try container.decode(Bool.self, forKey: .defaultCategory)
        self.size = try container.decode(Int.self, forKey: .size)
        self.includeInUpdate = try container.decode(Int.self, forKey: .includeInUpdate)
        self.includeInDownload = try container.decode(Int.self, forKey: .includeInDownload)
        
        // Decode the meta property as a dictionary
//        if let metaDictionary = try? container.decode([String: Any].self, forKey: .meta) {
//            self.meta = metaDictionary
//        } else {
//            // Handle the case where meta is not a dictionary
//            self.meta = [:]
//        }
    }
    
    
}
