//
//  AttendeeView.swift
//  iOSDevUK
//
//  Created by David Kababyan on 10/09/2022.
//

import SwiftUI

struct AttendeeView: View {
    @EnvironmentObject var viewModel: BaseViewModel

    var categories: [String : [Location]] {
        .init(
            grouping: viewModel.locations,
            by: {$0.locationTypeRecordName }
        )
    }
    
    @ViewBuilder
    private func navigationBarTrailingItem() -> some View {
        NavigationLink {
            MapView(allLocations: viewModel.locations)
        } label: {
            Text("All locations")
                .bold()
        }
    }
    
    @ViewBuilder
    private func informationView() -> some View {
        ForEach(viewModel.infoItems) { item in
            HStack {
                Text(item.name)
                Spacer()
                Image(systemName: ImageNames.chevronRight)
                    .font(.caption2)
            }
            .onTapGesture {
                viewModel.goTo(link: item.link)
            }
        }
    }
    
    @ViewBuilder
    private func locationCategoryView() -> some View {
        
        ForEach(categories.keys.sorted(), id: \String.self) { key in
            
            Section(locationName(from: key)) {
                ForEach(categories[key] ?? [], id: \.id) { location in
                    
                    NavigationLink(value: location) {
                        Text(location.name)
                            .font(.subheadline)
                            .lineLimit(1)
                            .minimumScaleFactor(0.6)
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    private func main() -> some View {
        
        Form {
            Section("Information") {
                informationView()
            }
            
            Section { } header: {
                Text("Locations")
                      .font(.headline)
                      .foregroundColor(.primary)
            }
            .padding(.bottom, -10)
                
            locationCategoryView()
        }
    }

    var body: some View {
        main()
            .navigationTitle("Attendee Info")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing, content: navigationBarTrailingItem)
            }
            .navigationDestination(for: Location.self) { location in
                MapView(allLocations: [location])
            }
    }
}

struct AttendeeView_Previews: PreviewProvider {
    static var previews: some View {
        AttendeeView()
    }
}
