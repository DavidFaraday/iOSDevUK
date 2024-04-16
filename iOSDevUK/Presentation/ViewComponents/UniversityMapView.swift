//
//  UniversityMapView.swift
//  iOSDevUK
//
//  Created by David Kababyan on 01/04/2024.
//

import SwiftUI

struct UniversityMapView: View {
    let eventDate: String?
    
    init(eventDate: String? = nil) {
        self.eventDate = eventDate
    }
    
    var body: some View {
        ZStack {
            Image(ImageNames.mapImage)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: eventDate != nil ? 170 : 144)
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
            .padding(.top, 2)
        }
    }
}

#Preview {
    UniversityMapView(eventDate: nil)
}
