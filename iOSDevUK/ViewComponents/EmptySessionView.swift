//
//  EmptySessionView.swift
//  iOSDevUK
//
//  Created by David Kababyan on 05/03/2023.
//

import SwiftUI

struct EmptySessionView: View {
    
    private let message: String
    
    init(message: String) {
        self.message = message
    }
    
    var body: some View {
        
        ZStack {
            Color(.systemBackground)
                .edgesIgnoringSafeArea(.all)

            VStack {
                Image(systemName: "list.bullet.rectangle.portrait")
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(Color(ColorNames.secondary), Color(ColorNames.primary))
                    .font(.system(size: 120))

                Text(message)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.secondary)
                    .padding()
            }
            .offset(y: -50)
        }
    }
}

struct EmptySessionView_Previews: PreviewProvider {
    static var previews: some View {
        EmptySessionView(message: "You currently have no sessions added. \n Please bookmark sessions to see them here.")
    }
}
