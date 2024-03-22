//
//  EventInfoView.swift
//  iOSDevUK
//
//  Created by David Kababyan on 18/03/2024.
//

import SwiftUI

struct EventInfoView: View {
    
    let eventDate: String?
    let notificationBody: String?
    
    @ViewBuilder
    private func titleView() -> some View {
        ZStack {
            Image("mapImage")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 170)
                .clipShape(RoundedRectangle(cornerRadius: 16))
            
            VStack(alignment: .leading, spacing: 10) {
                
                if let eventDate {
                    Text(eventDate)
                        .appFont(size: 16)
                        .foregroundStyle(Color(.buttonTitle))
                        .capsuleBackgroundView(
                            height: 44,
                            color: Color(.buttonBackground)
                        )
                }
                
                HStack(spacing: 10) {
                    Image(ImageResource.mapPin)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 28)
                        .foregroundStyle(Color(.buttonBackground))
                    
                    Text("Aberystwyth University")
                        .semiboldAppFont(size: 20)
                        .foregroundStyle(Color(.mainText))
                    
                    Spacer()
                }
                .roundBackgroundView(color: Color(.buttonTitle))
            }
            .padding(.horizontal, 20)
            .padding(.top, 10)
        }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Details")
                .foregroundStyle(Color(.mainText))
                .boldAppFont(size: 20)
            
            titleView()
            
            if let notificationBody {
                Text(notificationBody)
                    .appFont(size: 16)
                    .foregroundStyle(Color(.mainText))
            }
        }
    }
}

#Preview {
    EventInfoView(eventDate: "", notificationBody: "")
}
