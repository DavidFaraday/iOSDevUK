//
//  LocationDeniedLabel.swift
//  iOSDevUK
//
//  Created by Uladzislau Ramanenka on 02/07/2023.
//

import SwiftUI

struct LocationDeniedLabel: View {
    var body: some View {
        Text("Location access denied.\n You can enable it in Setting->Privacy & Security.")
            .font(.caption)
            .foregroundColor(.pink)
            .frame(maxWidth: .infinity)
            .multilineTextAlignment(.center)
            .padding(.horizontal)
    }
}

struct LocationDeniedLabel_Previews: PreviewProvider {
    static var previews: some View {
        LocationDeniedLabel()
    }
}
