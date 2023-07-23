//
//  AppInformationView.swift
//  iOSDevUK
//
//  Created by David Kababyan on 13/09/2022.
//

import SwiftUI

struct AppInformationView: View {
    @EnvironmentObject var viewModel: BaseViewModel

    var body: some View {
        
        ScrollView {
            VStack(spacing: 20) {
                
                Image("appIcon")
                    .cornerRadius(20)
                                
                Text("The app has been created with Beer & SwiftUI by David Kababyan ([@Dave_iOSDev](https://twitter.com/Dave_iOSDev)), with contributions from Neil Taylor ([@digidol](https://twitter.com/digidol).\n\nApp data wrangling by Chris Price ([@iOSDevUK](https://twitter.com/iOSDevUK)).")
                
                Text("Thanks to John Gilbey ([@John_Gilbey](https://twitter.com/John_Gilbey)) for his picture of conference attendees that is used in this app.")
                
                Text("Other images by Neil & Chris.")
                
                if let twitterUrl = URL(string: TwitterAccounts.developer) {
                    Link("Contact the developer", destination: twitterUrl)
                }
                if let twitterUrl = URL(string: TwitterAccounts.digidol) {
                    Link("Contact @digidol", destination: twitterUrl)
                }

                Spacer()
            }
            .multilineTextAlignment(.center)
            .padding(.top, 25)
            .padding()
            .navigationTitle("App Info")
            .navigationBarTitleDisplayMode(.inline)
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
