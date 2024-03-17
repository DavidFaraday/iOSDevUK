//
//  AttendeeRowView.swift
//  iOSDevUK
//
//  Created by David Kababyan on 17/03/2024.
//

import SwiftUI

struct AttendeeRowView: View {
    let subtitle: String?
    let title: String
    let description: String
    let image: Image
    
    init(subtitle: String? = nil, title: String, description: String, image: Image) {
        self.subtitle = subtitle
        self.title = title
        self.description = description
        self.image = image
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 10) {
                if let subtitle {
                    Text(subtitle)
                        .appFont(size: 12)
                        .foregroundStyle(Color(.purple200))
                }
                
                Text(title)
                    .semiboldAppFont(size: 22)
                    .foregroundStyle(Color(.mainText))
                
                Text(description)
                    .multilineTextAlignment(.leading)
                    .appFont(size: 14)
                    .foregroundStyle(Color(.textBody))
            }
            
            Spacer()
            
            image
        }
        .padding(10)
        .roundBackgroundView(color: Color(.speakerCardBackground))
    }
}

#Preview {
    AttendeeRowView(subtitle: nil, title: "", description: "", image: Image(systemName: "circle"))
}
