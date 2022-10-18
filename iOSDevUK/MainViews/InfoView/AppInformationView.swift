//
//  AppInformationView.swift
//  iOSDevUK
//
//  Created by David Kababyan on 13/09/2022.
//

import SwiftUI

struct AppInformationView: View {
    
    
    var body: some View {
        
        VStack(spacing: 20) {
            Image(ImageNames.appIcon)
                .resizable()
                .frame(width: 150, height: 150)
            
            Text("App Version: \(Bundle.main.appVersionLong)")
            
            Text("The app has been created with Beer & SwiftUI by David Kababyan @Dave_iOSDev \nApp data curated wrangled by Chris")
            
            Text("Thanks to @John_Gilbey for his picture of conference attendees that is used in this app.")
            Text("Some of the artwork uses icons from @glyphish(www.glyphish.com).")
            Text("Other images by Neil & Chris.")
            
            Button("Email the developer") {
                //TODO: add email link
            }
            
            Button("Contact @digibol") {
                //TODO: Add twitter link
            }

            Spacer()
        }
        .multilineTextAlignment(.center)
        .padding(10)
        .navigationTitle("App Info")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct AppInformationView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AppInformationView()
        }
        
    }
}
