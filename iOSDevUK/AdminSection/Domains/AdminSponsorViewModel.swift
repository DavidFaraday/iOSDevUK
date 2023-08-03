//
//  AdminSponsorViewModel.swift
//  iOSDevUK
//
//  Created by David Kababyan on 05/03/2023.
//

import Foundation
import Factory

final class AdminSponsorViewModel: ObservableObject {
    @Injected(\.firebaseRepository) private var firebaseRepository

    @Published var name = ""
    @Published var url = ""
    @Published var urlText = ""
    @Published var category = SponsorCategory.Silver
    @Published var imageLinkDark = ""
    @Published var imageLinkLight = ""
    @Published var tagline = "About the sponsor"
    
    var sponsor: Sponsor?
    
    init(sponsor: Sponsor? = nil) {
        self.sponsor = sponsor
        setupUI()
    }
    
    private func setupUI() {
        guard let sponsor = sponsor else { return }
        
        name = sponsor.name
        url = sponsor.url
        urlText = sponsor.urlText
        imageLinkDark = sponsor.imageLinkDark ?? ""
        imageLinkLight = sponsor.imageLinkLight ?? ""
        tagline = sponsor.tagline
        category = sponsor.sponsorCategory
    }
    
    func save() async {
        let newSponsor = Sponsor(id: sponsor?.id ?? name.removeSpaces, name: name, tagline: tagline, url: url, urlText: urlText, sponsorCategory: category, imageLinkDark: imageLinkDark, imageLinkLight: imageLinkLight)
    
        do {
            try firebaseRepository.saveData(data: newSponsor, to: .Sponsor)
        }
        catch {
            print("Error saving sponsor", error.localizedDescription)
        }
    }
    
    func deleteSponsor(_ sponsor: Sponsor) {
        firebaseRepository.deleteDocument(with: sponsor.id, from: .Sponsor)
    }
    
    func invalidForm() -> Bool {
        name == "" || url == "" || urlText == "" || imageLinkDark == "" || imageLinkLight == "" || tagline == ""
    }
}
