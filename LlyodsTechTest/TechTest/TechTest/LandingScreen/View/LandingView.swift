//
// LandingView.swift
//  TechTest
//
//  Created by vivek on 26/12/24.
//

import SwiftUI

struct LandingView: View {
    @StateObject var viewModel = LandingViewModel()
    @State var isLoaded: Bool = false
    var body: some View {
        ZStack{
            VStack(alignment: .leading, spacing: 5.0) {
                ReusableText(textTitle: viewModel.details?.verse ?? "", font: .title) // Reusable component...
                if isLoaded { Divider() }
                ReusableText(textTitle: viewModel.details?.translation ?? "", font:.title3, color: .blue)
                Spacer()
            }
        }
        .task {
            let task = await viewModel.getVerseDetails() // Network call..
            if let verses = try? await task.value {
                viewModel.details = verses
                isLoaded = true
            }
        }
    }
}
