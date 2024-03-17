//
//  TabBarView.swift
//  iOSDevUK
//
//  Created by David Kababyan on 10/09/2022.
//

import SwiftUI

struct TabBarView: View {
        
    var body: some View {
        TabView {
            ForEach(Tab.allCases) { tab in
                tab.view
                    .tabItem {
                        tab.icon
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    }
            }
        }
    }
}

extension TabBarView {
    fileprivate enum Tab: CaseIterable, Identifiable {
        case home
        case mySchedule
        case attendee
        case info
        
        var id: Int {
            self.hashValue
        }
                
        var icon: Image {
            switch self {
                case .home:
                    return Image(ImageNames.home)
                case .mySchedule:
                    return Image(ImageNames.schedule)
                case .attendee:
                    return Image(ImageNames.attendee)
                case .info:
                    return Image(ImageNames.info)
            }
        }
        
        @ViewBuilder
        var view: some View {
            switch self {
                case .home:
                    HomeView()
                case .mySchedule:
                    MyScheduleView()
                case .attendee:
                    AttendeeScreen()
                case .info:
                    InfoView()
            }
        }
    }
}

