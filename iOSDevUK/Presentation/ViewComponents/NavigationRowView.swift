//
//  NavigationRowView.swift
//  iOSDevUK
//
//  Created by David Kababyan on 05/08/2023.
//

import SwiftUI

struct NavigationRowView: View {
    let imageName: String
    let title: String
    
    var body: some View {
        HStack(spacing: 15) {
            Image(imageName)
                .tint(Color(.mainText))
            
            Text(title)
                .semiboldAppFont(size: 16)
                .foregroundStyle(Color(.mainText))
            
            Spacer()
            Image(systemName: ImageNames.chevronRight)
                .tint(Color(.mainText))
        }
        .padding(4)
        .roundBackgroundView(color: Color(.cardBackground))
    }
}

struct NavigationRowView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationRowView(imageName: ImageNames.mapPin, title: AppStrings.sponsors)
    }
}
