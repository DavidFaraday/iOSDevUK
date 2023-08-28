//
//  SessionRowFavouriteButton.swift
//  iOSDevUK
//
//  Created by Uladzislau Ramanenka on 28/08/2023.
//

import SwiftUI

struct SessionRowFavouriteButton: View {
    @StateObject private var myScheduleViewModel = MyScheduleViewModel()

    let sessionId: String

    var body: some View {
        Spacer()
        Button {} label: {
            Image(systemName: myScheduleViewModel.favoriteSessionIds.contains(sessionId) ? ImageNames.bookmarkFill : ImageNames.bookmark)
        }
        .onTapGesture {
            myScheduleViewModel.updateFavoriteSession(id: sessionId)
        }
        .onAppear() {
            myScheduleViewModel.loadFavSessions()
        }
    }
}

struct SessionRowFavouriteButton_Previews: PreviewProvider {
    static var previews: some View {
        SessionRowFavouriteButton(sessionId: DummyData.sessions[0].id)
    }
}
