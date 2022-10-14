//
//  SessionRowView.swift
//  iOSDevUK
//
//  Created by David Kababyan on 07/10/2022.
//

import SwiftUI

struct SessionRowView: View {
    @StateObject private var viewModel: SessionRowViewModel
    
    init(session: Session) {
        self.init(viewModel: SessionRowViewModel(session: session))
    }
    
    private init(viewModel: SessionRowViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(viewModel.session.title)
                .font(.title3)
            Text("\(viewModel.location?.name ?? ""), \(viewModel.session.startDate.weekDayTime())")
                .font(.caption)
        }
        .minimumScaleFactor(0.8)
        .lineLimit(2)
        .task(viewModel.fetchLocation)
    }
}

struct SessionRowView_Previews: PreviewProvider {
    static var previews: some View {
        SessionRowView(session: DummyData.session)
    }
}
