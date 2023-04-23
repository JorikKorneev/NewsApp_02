//
//  NewsModel.swift
//
//  Created by admin on 20.04.2023.


// JSON parsing model

import Foundation
import UIKit
import CloudKit

// MARK: - Welcome
struct NewsItem: Codable {

    let articles: [Article]?
}

// MARK: - Article
struct Article: Codable {
    
    let source: Source
    let author: String?
    let title, description: String
    let url: String
    let urlToImage: String?
    let publishedAt: String
    let content: String
}

struct Source: Codable {
    let id: String?
    let name: String?
}
