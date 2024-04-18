//
//  AppInformationView.swift
//  iOSDevUK
//
//  Created by David Kababyan on 13/09/2022.
//

import SwiftUI

struct AppInformationView: View {
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
            VStack(spacing: 20) {
                                
                Text("The app has been developed by David Kababyan ([@Dave_iOSDev](https://twitter.com/Dave_iOSDev)), with contributions from Neil Taylor ([@digidol](https://twitter.com/digidol)).\n\nApp data wrangling by Chris Price ([@iOSDevUK](https://twitter.com/iOSDevUK)).")
                
                Text("Designed by Oksana Korotun ([@LinkedIn](https://linkedin.com/in/oksana-korotun/)).")

                Text("Thanks to John Gilbey ([@John_Gilbey](https://twitter.com/John_Gilbey)) for his picture of conference attendees that is used in this app.")

                Text("Other images by Neil & Chris.")
                
                VStack(spacing: 10) {
                    if let twitterUrl = URL(string: ContactAccounts.developer) {
                        Link("Contact the developer", destination: twitterUrl)
                    }
                    
                    if let linkedInUrl = URL(string: ContactAccounts.designer) {
                        Link("Contact the designer", destination: linkedInUrl)
                    }
                    
                    if let twitterUrl = URL(string: ContactAccounts.digidol) {
                        Link("Contact @digidol", destination: twitterUrl)
                    }
                }
                .tint(Color(.purple300))

                Spacer()
            }
            .appFont(size: 16)
            .multilineTextAlignment(.center)
            .padding(.top, 25)
            .padding()
            .navigationTitle(AppStrings.appInfo)
            .navigationBarBackButtonHidden()
            .toolbar {
                ToolbarItem(placement: .topBarLeading, content: navigationBarLeadingItem)
            }

        }
    }
}

struct AppInformationView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                AppInformationView()
                    .preferredColorScheme(.dark)
            }
            NavigationView {
                AppInformationView()
                    .preferredColorScheme(.light)
            }
        }
    }
}
