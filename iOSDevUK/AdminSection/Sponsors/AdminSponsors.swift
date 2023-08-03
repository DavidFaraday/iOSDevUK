//
//  AdminSponsors.swift
//  iOSDevUK
//
//  Created by David Kababyan on 20/10/2022.
//

import SwiftUI

struct AdminSponsors: View {
    @EnvironmentObject var viewModel: BaseViewModel
    @StateObject private var adminSponsorViewModel = AdminSponsorViewModel()
    
    @ViewBuilder
    private func navigationBarTrailingItem() -> some View {
        NavigationLink(value: InfoDestination.adminAddSponsor(nil)) {
            Image(systemName: ImageNames.plus)
                .font(.title3)
        }
    }

    
    @ViewBuilder
    private func main() -> some View {
        Form {
            ForEach(viewModel.sponsors, id: \.id) { sponsor in
                NavigationLink(value: InfoDestination.adminAddSponsor(sponsor)) {
                    
                    HStack(spacing: 5) {
                        ZStack {
                            Circle()
                                .frame(width: 20)
                                .foregroundColor(sponsor.sponsorCategory.color)
                            Text(sponsor.sponsorCategory.rawValue.prefix(1))
                                .fontWeight(.bold)
                                .foregroundColor(.black)
                                .font(.system(size: 13))
                        }
                        
                        Text(sponsor.name)
                            .font(.subheadline)
                    }
                }
            }
            .onDelete { indexSet in
                guard let index = indexSet.first else { return }
                adminSponsorViewModel.deleteSponsor(viewModel.sponsors[index])
            }
        }
        .listStyle(.plain)
    }
    
    var body: some View {
        main()
            .navigationTitle(AppStrings.sponsors)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing, content: navigationBarTrailingItem)
            }
    }
}

struct AdminSponsors_Previews: PreviewProvider {
    static var previews: some View {
        AdminSponsors()
    }
}
