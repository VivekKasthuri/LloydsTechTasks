//
//  LandingModel.swift
//  TechTest
//
//  Created by Vivek on 26/12/24.
//

import Foundation

// MARK: Data holders for the server values..
struct BookDetails: Codable {
    
    let chapter_no, verse_no: Int
    let language, chapter_name, verse, transliteration: String
    let synonyms: String
    let audio_link: String
    let translation: String
    let purport: [String]
    
    init(chapter_no: Int, verse_no: Int, language: String, chapter_name: String, verse: String, transliteration: String, synonyms: String, audio_link: String, translation: String, purport: [String]) {
        self.chapter_no = chapter_no
        self.verse_no = verse_no
        self.language = language
        self.chapter_name = chapter_name
        self.verse = verse
        self.transliteration = transliteration
        self.synonyms = synonyms
        self.audio_link = audio_link
        self.translation = translation
        self.purport = purport
    }
}
