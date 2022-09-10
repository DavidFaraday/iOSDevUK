//
//  MyScheduleView.swift
//  iOSDevUK
//
//  Created by David Kababyan on 10/09/2022.
//

import SwiftUI

struct MyScheduleView: View {
    @StateObject private var viewModel: MyScheduleViewModel

    init(viewModel: MyScheduleViewModel = MyScheduleViewModel()) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        Text("MySchedule")
            .navigationTitle("My Schedule")
    }
}

struct MyScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        MyScheduleView()
    }
}
