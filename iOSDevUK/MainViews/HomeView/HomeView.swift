//
//  HomeView.swift
//  iOSDevUK
//
//  Created by David Kababyan on 10/09/2022.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel: HomeViewModel

    init(viewModel: HomeViewModel = HomeViewModel()) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    @ViewBuilder
    private func speakerView() -> some View {
        
        VStack(alignment: .leading) {
            Text("Speakers")
                .font(.title2)
                .bold()
            
            ScrollView(.horizontal) {
                HStack(spacing: 10) {
                    ForEach(Speaker.arrayOfSpeakers) { speaker in
                        SpeakerCellView(speaker: speaker)
                            .frame(width: 130, height: 200)
                    }
                }
            }
            .scrollIndicators(.hidden)
        }
        .padding(.bottom)
    }
    
    @ViewBuilder
    private func headerView() -> some View {
        
        VStack {
            Text(viewModel.eventNotification)
                .font(.title3)
                .minimumScaleFactor(0.8)
                .multilineTextAlignment(.center)

        }
        .frame(maxWidth: .infinity)
        .padding(10)
        .background(.ultraThickMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }

    @ViewBuilder
    private func footerView() -> some View {
        
        VStack(alignment: .center, spacing: 10) {
            Text(viewModel.aboutString)
                .multilineTextAlignment(.center)
                .minimumScaleFactor(0.8)
                .font(.body)
                .padding()
            
            Button("@iOSDevUK on Twitter") {
                viewModel.showTwitterAccount("iOSDevUK")
            }
            
            Button("@AberCompSci on Twitter") {
                viewModel.showTwitterAccount("AberCompSci")
            }
        }
        .frame(maxWidth: .infinity)
        .padding(10)
        .background(.ultraThickMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
    
    @ViewBuilder
    private func main() -> some View {
        
        ScrollView {
            headerView()
            speakerView()
            speakerView()
            footerView()
        }
        .scrollIndicators(.hidden)
        .padding()
    }

    var body: some View {
        main()
            .navigationTitle("iOSDevUK")
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
