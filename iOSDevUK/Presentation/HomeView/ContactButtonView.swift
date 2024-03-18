//
//  ContactButtonView.swift
//  iOSDevUK
//
//  Created by David Kababyan on 18/03/2024.
//

import SwiftUI

struct ContactButtonView: View {
    let imageName: String
    let title: String
    
    var body: some View {
        HStack {
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 22)
                .foregroundStyle(Color(.mainText))
            
            Spacer()
            
            Text(title)
                .semiboldAppFont(size: 14)
                .foregroundStyle(Color(.mainText))
            
            Spacer()
        }
        .capsuleOutlineView()
    }
}

#Preview {
    ContactButtonView(imageName: "", title: "")
}
