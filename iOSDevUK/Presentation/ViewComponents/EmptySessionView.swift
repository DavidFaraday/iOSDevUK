//
//  EmptySessionView.swift
//  iOSDevUK
//
//  Created by David Kababyan on 05/03/2023.
//

import SwiftUI

//struct EmptySessionView: View {
//    
//    private let title: String
//    private let message: String
//    private let buttonTitle: String
//    private let buttonAction: () -> Void?
//    
//    init(title: String, message: String, buttonTitle: String = "", buttonAction: @escaping () -> Void) {
//        self.message = message
//        self.buttonTitle = buttonTitle
//        self.buttonAction = buttonAction
//    }
//    
//    var body: some View {
//
//        VStack(spacing: 12) {
//            Image(.emotySchedule)
//                .resizable()
//                .frame(width: 80, height: 80)
//                .foregroundStyle(Color(.emptyIcon))
//
//            Text(message)
//                .semiboldAppFont(size: 20)
//                .foregroundStyle(Color(.mainText))
//            
//            Button(buttonTitle, action: buttonAction)
//                .buttonStyle(.borderedProminent)
//                .tint(Color(ColorNames.secondary))
//        }
//        .offset(y: -50)
//    }
//}
//
//struct EmptySessionView_Previews: PreviewProvider {
//    static var previews: some View {
//        EmptySessionView(message: "You currently have no sessions added. \n Please bookmark sessions to see them here.") {
//            
//        }
//    }
//}


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
                        .foregroundStyle(Color(.emptyIcon))
                    
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
                    .foregroundStyle(Color(.emptyIcon))
                
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
