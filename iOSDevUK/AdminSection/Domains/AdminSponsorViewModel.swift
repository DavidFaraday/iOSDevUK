//
//  AdminSponsorViewModel.swift
//  iOSDevUK
//
//  Created by David Kababyan on 05/03/2023.
//

import Foundation

final class AdminSponsorViewModel: ObservableObject {
    
    @Published var name = ""
    @Published var url = ""
    @Published var urlText = ""
    @Published var category = SponsorCategory.Silver
    @Published var imageLink = ""
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
        imageLink = sponsor.imageLink ?? ""
        tagline = sponsor.tagline
        category = sponsor.sponsorCategory
    }
    
    func save() async {
        let newSponsor = Sponsor(id: sponsor?.id ?? UUID().uuidString, name: name, tagline: tagline, url: url, urlText: urlText, sponsorCategory: category, imageLink: imageLink)
    
        do {
            try FirebaseReference(.Sponsor).document(newSponsor.id).setData(from: newSponsor)
        }
        catch {
            print("Error saving sponsor", error.localizedDescription)
        }
    }
    
    func deleteSponsor(_ sponsor: Sponsor) {
        FirebaseReference(.Sponsor).document(sponsor.id).delete()
    }
    
    func invalidForm() -> Bool {
        name == "" || url == "" || urlText == "" || imageLink == "" || tagline == ""
    }
}
