//
//  AppSegmentControl.swift
//  iOSDevUK
//
//  Created by David Kababyan on 20/03/2024.
//

import SwiftUI

import SwiftUI

struct AppSegmentedControl<T: CaseIterable & RawRepresentable>: View where T.RawValue == String {
    
    @Binding var selection: Int
    
    var options: [T] {
        return T.allCases as! [T]
    }
    
    
    var body: some View {
        HStack(spacing: 2) {
            ForEach(options.indices, id:\.self) { index in
                
                Rectangle()
                    .foregroundStyle(Color(.buttonBackground))
                    .cornerRadius(20)
                    .padding(2)
                    .opacity(selection == index ? 1 : 0.1)
                    .onTapGesture {
                        withAnimation(.interactiveSpring()) {
                            selection = index
                        }
                    }
                    .overlay(
                        Text(options[index].rawValue.capitalized)
                            .semiboldAppFont(size: 18)
                            .foregroundStyle(selection == index ? Color(.buttonTitle) : Color(.segmentTitle))
                    )
            }
        }
        .frame(height: 40)
        .cornerRadius(20)
    }
}
