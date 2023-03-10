//
//  ErrorEntity.swift
//  Intro-Lab
//
//  Created by Александр Головин on 04.02.2023.
//

import Foundation

enum NError: String, Error {
    case invalidUrl
    case unableToComplete
    case invalidData
    case invalidJson
}
