//
//  AboutView.swift
//  iOSDevUK
//
//  Created by David Kababyan on 13/09/2022.
//

import SwiftUI

struct AboutView: View {
    
    var body: some View {
        ScrollView {
            Image(ImageNames.img4)
                .resizable()
                .aspectRatio(contentMode: .fit)

            VStack(alignment: .leading, spacing: 20) {
                //TODO: pass dates from FB
                Text("iOSDevUK is the UK conference for iOS developers. It takes place in Aberystwyth, on the mid-Wales coast, from 5th to the 8th September.")
                
                Text("•Great talks \n•Great get-togethers \n•Optional workshops")
                    .multilineTextAlignment(.leading)
                
                Text("The conference is organised by Aberystwyth University and is now in its tenth year. iOS, iPhone, iPad, Apple Watch, watchOS, Apple TV and tvOS are trademarks of Apple Inc. For the avoidance of doubt, Apple Inc. has no association with this conference.")
            }
            .padding(20)
        }
        .edgesIgnoringSafeArea(.top)
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
