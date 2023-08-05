//
//  NavigationRowView.swift
//  iOSDevUK
//
//  Created by David Kababyan on 05/08/2023.
//

import SwiftUI

struct NavigationRowView: View {
    let systemImageName: String
    let title: String
    
    var body: some View {
        HStack {
            Image(systemName: systemImageName)
                .font(.title3)
                .frame(width: 40)
                .dynamicTypeSize(.medium ... .accessibility1)
            Text(title)
                .padding(.leading, 10)
        }
    }
}

struct NavigationRowView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationRowView(systemImageName: ImageNames.heart, title: AppStrings.sponsors)
    }
}
