//
//  ReusableText.swift
//  TechTest
//
//  Created by Vivek on 26/12/24.
//

import Foundation
import SwiftUI

// MARK: ReusableText is a customview component inplace of Text component..
struct ReusableText: View {
    
    var textTitle: String
    var font: Font?
    var color: Color?
    
    init(textTitle: String, font: Font? = .title, color: Color = .black) {
        
        self.textTitle = textTitle
        self.font = font
        self.color = color
    }
    
    var body: some View {
        VStack {
            Text(self.textTitle)
                .font(font)
                .foregroundColor(color)
                .fontWeight(.semibold)
                .padding(.all)
        }
    }
}
