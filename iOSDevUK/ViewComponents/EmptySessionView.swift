//
//  EmptySessionView.swift
//  iOSDevUK
//
//  Created by David Kababyan on 05/03/2023.
//

import SwiftUI

struct EmptySessionView: View {
    
    private let message: String
    private let buttonTitle: String
    private let buttonAction: () -> Void
    
    init(message: String, buttonTitle: String = "", buttonAction: @escaping () -> Void) {
        self.message = message
        self.buttonTitle = buttonTitle
        self.buttonAction = buttonAction
    }
    
    var body: some View {
        ZStack {
            Color(.systemBackground)
                .edgesIgnoringSafeArea(.all)

            VStack {
                Image(systemName: ImageNames.bulletPoint)
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(Color(ColorNames.secondary), Color(ColorNames.primary))
                    .font(.system(size: 120))

                Text(message)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.secondary)
                    .padding()
                
                Button(buttonTitle, action: buttonAction)
                    .buttonStyle(.borderedProminent)
                    .tint(Color(ColorNames.secondary))
            }
            .offset(y: -50)
        }
    }
}

struct EmptySessionView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack() {
            EmptySessionView(message: AppStrings.emptySessionMessage, buttonTitle: AppStrings.takeMeThere)  {
            }
            .navigationTitle(AppStrings.mySessions)
        }
    }
}
