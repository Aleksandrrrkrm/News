//
//  NewsEntity.swift
//  Intro-Lab
//
//  Created by Александр Головин on 03.02.2023.
//

import Foundation

// MARK: - NewsEntity
struct NewsEntity: Codable {
    let status: String
    let totalResults: Int
    let articles: [Article]
}

// MARK: - Article
struct Article: Codable {
    let title: String
    let description: String?
    let url: URL?
    let urlToImage: URL?
    let publishedAt: Date
    let author: String?
}
