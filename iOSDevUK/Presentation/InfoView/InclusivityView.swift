//
//  InclusivityView.swift
//  iOSDevUK
//
//  Created by David Kababyan on 11/09/2022.
//

import SwiftUI

struct InclusivityView: View {
    @EnvironmentObject var viewModel: BaseViewModel
    @Environment(\.presentationMode) var presentationMode

    
    @ViewBuilder
    private func navigationBarLeadingItem() -> some View {
        Button { presentationMode.wrappedValue.dismiss() }
        label: { Image(.back) }
            .tint(Color(.mainText))
    }

    var body: some View {
        ScrollView {
            Image(.conference)
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
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading, content: navigationBarLeadingItem)
        }

    }
}

struct InclusivityViewView_Previews: PreviewProvider {
    static var previews: some View {
        InclusivityView()
    }
}
