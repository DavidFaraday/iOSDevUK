//
//  SessionsHorizontalScrollView.swift
//  iOSDevUK
//
//  Created by David Kababyan on 09/04/2024.
//

import SwiftUI

struct SessionsHorizontalScrollView: View {
    let sessions: [Session]
    let geometry: GeometryProxy
        
    var body: some View {
        
        VStack(alignment: .leading) {
            HStack {
                Text(AppStrings.sessions)
                    .foregroundStyle(Color(.mainText))
                    .boldAppFont(size: 20)
                
                Spacer()
                NavigationLink(AppStrings.viewAll, value: Destination.sessions(sessions))
                    .foregroundStyle(Color(.textGrey))
            }
            .padding(.horizontal)
            
            if #available(iOS 17.0, *) {
                ScrollView(.horizontal) {
                    LazyHStack(spacing: 10) {
                        ForEach(sessions, id: \.self) { session in
                            
                            NavigationLink(value: Destination.session(session)) {
                                SessionCardView(session: session, geometry: geometry)
                                    .id(session)
                            }
                        }
                    }
                    .scrollTargetLayout()
                }
                .scrollTargetBehavior(.viewAligned)
                .safeAreaPadding(.horizontal, 20)
                .scrollIndicators(.hidden)
            } else {
                ScrollView(.horizontal) {
                    LazyHStack(spacing: 10) {
                        ForEach(sessions, id: \.self) { session in
                            
                            NavigationLink(value: Destination.session(session)) {
                                SessionCardView(session: session, geometry: geometry)
                                    .id(session)
                            }
                        }
                    }
                    .padding(.leading, 16)
                }
                .scrollIndicators(.hidden)
            }
        }
    }
}
