//
//  DropDownRowView.swift
//  iOSDevUK
//
//  Created by David Kababyan on 01/04/2024.
//

import SwiftUI

struct DropDownRowView: View {
    let title: String
    let imageName: String
    let locations: [Location]
    @State private var isExpanded = false
    
    var body: some View {
        VStack(alignment: .leading) {
            LocationHeaderView(
                text: title,
                imageName: imageName,
                isExpanded: isExpanded
            ) {
                withAnimation {
                    isExpanded.toggle()
                }
            }
            
            if isExpanded {
                ForEach(locations) { location in
                    NavigationLink(value: InfoDestination.locations(locations: [location])) {
                        Text(location.name)
                            .semiboldAppFont(size: 16)
                            .lineLimit(1)
                            .minimumScaleFactor(0.6)
                    }
                    .tint(Color(.buttonBackground))
                    .frame(height: 44)
                    .padding(.horizontal, 10)
                }
            }
        }
        .roundBackgroundView(color: Color(.cardBackground))
    }
}

#Preview {
    DropDownRowView(title: "Aber uni", imageName: "", locations: [DummyData.location, DummyData.location])
}
