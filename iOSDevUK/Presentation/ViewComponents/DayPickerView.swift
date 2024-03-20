//
//  DayPickerView.swift
//  iOSDevUK
//
//  Created by David Kababyan on 20/03/2024.
//

import SwiftUI

struct DayPickerView: View {
    
    let days: [String]
    @Binding var selection: String
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(days, id: \.self) { day in
                    VStack(spacing: 20) {
                        Text(day.removeChars)
                            .semiboldAppFont(size: 20)
                        Text(day.removeDigits.uppercased())
                            .appFont(size: 14)
                    }
                    .frame(width: 54, height: 56)
                    .foregroundStyle(selection == day ? Color(.buttonTitle) : Color(.mainText))
                    .roundBackgroundView(color: selection == day ? Color(.pickerSelected) : Color(.pickerBackground))
                    .onTapGesture {
                        selection = day
                    }
                }
            }
            .padding(.leading)
        }
    }
}

//#Preview {
//    DayPickerView()
//}
