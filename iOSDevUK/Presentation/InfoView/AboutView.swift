//
//  AboutView.swift
//  iOSDevUK
//
//  Created by David Kababyan on 13/09/2022.
//

import SwiftUI

struct AboutView: View {
    @EnvironmentObject var viewModel: BaseViewModel

    var body: some View {
        ScrollView {
            Image(.aboutBackground)
                .resizable()
                .aspectRatio(contentMode: .fit)

            VStack(alignment: .leading, spacing: 20) {

                Text("iOSDevUK is the UK conference for iOS developers. It takes place in Aberystwyth, on the mid-Wales coast, from \(viewModel.eventInformation?.startDate.dayOfTheMonth ?? "") to the \(viewModel.eventInformation?.endDate.dayAndMonth ?? "").")
                
                Text("• Great talks\n• Great get-togethers\n• Optional workshops")                    .multilineTextAlignment(.leading)
                
                Text("The conference is organised by Aberystwyth University and is now in its eleventh year. iOS, iPhone, iPad, Apple Watch, watchOS, Apple TV and tvOS are trademarks of Apple Inc. For the avoidance of doubt, Apple Inc. has no association with this conference.")
            }
            .padding(20)
        }
        .appFont(size: 16)
        .foregroundStyle(Color(.textBody))
        .edgesIgnoringSafeArea(.top)
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
