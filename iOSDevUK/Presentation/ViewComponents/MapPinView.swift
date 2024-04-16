//
//  MapPinView.swift
//  iOSDevUK
//
//  Created by David Kababyan on 06/04/2024.
//

import SwiftUI

struct MapPinView: View {
    let imageName: String
    let isSelected: Bool
    
    var body: some View {
        ZStack(alignment: .top) {
            MapPinShape()
                .fill(isSelected ? Color(.purple300) : Color(.mapPin))
                .frame(width: 70, height: 50)
            
            Image(imageName.lowercased())
                .resizable()
                .frame(width: 20, height: 20)
                .foregroundStyle(isSelected ? .white :  Color(.purple300))
                .padding(.top, 5)
        }
        .scaleEffect(isSelected ? 1.2 : 1.0)
        .padding(.horizontal, -20)
    }
}

#Preview {
    MapPinView(imageName: "ev", isSelected: false)
}
