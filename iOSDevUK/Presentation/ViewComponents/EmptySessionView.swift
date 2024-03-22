//
//  EmptySessionView.swift
//  iOSDevUK
//
//  Created by David Kababyan on 05/03/2023.
//

import SwiftUI

struct EmptyContentView: View {
    let image: Image
    let title: String
    let description: String?
    let buttonTitle: String?
    var action: (() -> ())?
    
    init(
        image: Image,
        title: String,
        description: String? = nil,
        buttonTitle: String? = nil,
        action: (() -> Void)? = nil
    ) {
        self.image = image
        self.title = title
        self.description = description
        self.buttonTitle = buttonTitle
        self.action = action
    }
    
    var body: some View {
        
        if #available(iOS 17.0, *) {
            ContentUnavailableView {
                VStack(spacing: 10) {
                    image
                        .resizable()
                        .frame(width: 80, height: 80)
                        .aspectRatio(contentMode: .fill)
                        .foregroundStyle(Color(.linkButton))
                    
                    Text(title)
                        .boldAppFont(size: 20)
                        .foregroundStyle(Color(.mainText))
                }
            } description: {
                if let description {
                    Text(description)
                        .multilineTextAlignment(.center)
                        .foregroundStyle(Color(.mainText))
                        .appFont(size: 16)
                }
            } actions: {
                if let action = action, let buttonTitle {
                    Button(action: action, label: {
                        Text(buttonTitle)
                    })
                    .buttonStyle(.appPrimary)
                }
            }
        } else {
            VStack(spacing: 12) {
                Spacer()

                image
                    .resizable()
                    .frame(width: 80, height: 80)
                    .foregroundStyle(Color(.linkButton))
                
                Text(title)
                    .semiboldAppFont(size: 20)
                    .foregroundStyle(Color(.mainText))
                
                if let description {
                    Text(description)
                        .multilineTextAlignment(.center)
                        .foregroundStyle(Color(.mainText))
                        .appFont(size: 16)
                }
                
                if let action = action, let buttonTitle {
                    Spacer()
                    
                    Button(action: action, label: {
                        Text(buttonTitle)
                    })
                    .buttonStyle(.appPrimary)
                    .padding([.horizontal, .bottom], 16)
                }
            }
        }
    }
}
