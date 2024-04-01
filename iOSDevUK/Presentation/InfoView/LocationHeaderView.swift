//
//  LocationHeaderView.swift
//  iOSDevUK
//
//  Created by David Kababyan on 01/04/2024.
//

import SwiftUI

struct LocationHeaderView: View {
    let text: String
    let imageName: String
    let isExpanded: Bool
    var action: () -> Void
    
    init(text: String, imageName: String, isExpanded: Bool, action: @escaping () -> Void) {
        self.text = text
        self.imageName = imageName
        self.isExpanded = isExpanded
        self.action = action
    }

    var body: some View {
        
        HStack(spacing: 10) {
            Image(imageName)
                .resizable()
                .frame(width: 20, height: 20)
                .foregroundStyle(Color(.icon))
                .roundBackgroundView(color: Color(.linkButton))
            
            Text(text)
                .boldAppFont(size: 16)
                .foregroundStyle(Color(.mainText))
            
            Spacer()
            
            Image(systemName: isExpanded ? ImageNames.chevronUp : ImageNames.chevronDown)
        }
        .contentShape(Rectangle()) //needed to recognise tap on empty space
        .onTapGesture {
            action()
        }
    }
}

#Preview {
    LocationHeaderView(text: "", imageName: "", isExpanded: false) {
        
    }
}
