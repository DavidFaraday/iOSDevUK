//
//  LocationCellView.swift
//  iOSDevUK
//
//  Created by David Kababyan on 10/09/2022.
//

import SwiftUI

struct LocationRowView: View {
    var location: Location?
    private let imageWidth: CGFloat = 40
    
    var body: some View {
        HStack {
            ZStack {
                Circle()
                    .frame(width: imageWidth + 5)
                    .foregroundColor(.green)
                
                RemoteImage(urlString: location?.imageLink ?? "")
                    .frame(width: imageWidth, height: imageWidth)
                    .clipShape(Circle())
            }
            
            Text(location?.name ?? "")
                .font(.subheadline)
                .lineLimit(1)
                .minimumScaleFactor(0.6)
        }
    }
}

struct LocationRowView_Previews: PreviewProvider {
    static var previews: some View {
        LocationRowView(location: DummyData.location)
    }
}
