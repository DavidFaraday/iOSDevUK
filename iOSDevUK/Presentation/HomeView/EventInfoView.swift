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
        
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Details")
                .foregroundStyle(Color(.mainText))
                .boldAppFont(size: 20)
            
            UniversityMapView(eventDate: eventDate)
            
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
