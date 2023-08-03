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
                        Text(tab.name)
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
                return Image(systemName: ImageNames.house)
            case .mySchedule:
                return Image(systemName: ImageNames.list)
            case .attendee:
                return Image(systemName: ImageNames.person)
            case .info:
                return Image(systemName: ImageNames.info)
            }
        }
        
        var name: String {
            switch self {
            case .home:
                return AppStrings.home
            case .mySchedule:
                return AppStrings.schedule
            case .attendee:
                return AppStrings.attendee
            case .info:
                return AppStrings.info
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
                AttendeeView()
            case .info:
                InfoView()
            }
        }
    }
}

