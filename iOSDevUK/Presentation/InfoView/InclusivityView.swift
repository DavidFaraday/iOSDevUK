//
//  InclusivityView.swift
//  iOSDevUK
//
//  Created by David Kababyan on 11/09/2022.
//

import SwiftUI

struct InclusivityView: View {
    @EnvironmentObject var viewModel: BaseViewModel

    var body: some View {
        ScrollView {
            Image(ImageNames.conferenceImage)
                .resizable()
                .aspectRatio(contentMode: .fit)

            Text(AppStrings.inclusivityPolicy)
                .semiboldAppFont(size: 24)
                .foregroundStyle(Color(.mainText))
                .minimumScaleFactor(0.7)
            
            Spacer()

            if let inclusivityText = viewModel.eventInformation?.inclusivityText {
                Text(inclusivityText)
                    .appFont(size: 16)
                    .foregroundStyle(Color(.textBody))
                    .lineLimit(nil)
                    .padding()
            }
        }
        .edgesIgnoringSafeArea(.top)
    }
}

struct InclusivityViewView_Previews: PreviewProvider {
    static var previews: some View {
        InclusivityView()
    }
}
