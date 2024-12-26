//
//  LandingModel.swift
//  TechTest
//
//  Created by Vivek on 26/12/24.
//

import Foundation

struct BookDetails: Codable {
    let chapter_no, verse_no: Int
    let language, chapter_name, verse, transliteration: String
    let synonyms: String
    let audio_link: String
    let translation: String
    let purport: [String]
}
