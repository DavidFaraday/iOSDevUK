//
//  Constants.swift
//  iOSDevUK
//
//  Created by David Kababyan on 18/10/2022.
//

import Foundation

struct ImageNames {
    static let img1 = "img1"
    static let img2 = "img2"
    static let img3 = "img3"
    static let img4 = "img4"
    static let appIcon = "appIcon"
    static let conferenceImage = "conferenceImage"
    static let bookmark = "bookmark"
    static let bookmarkFill = "bookmark.fill"
    static let house = "house"
    static let list = "list.bullet"
    static let person = "person"
    static let info = "info"
    static let chevronRight = "chevron.right"
    static let checkmark = "checkmark"
}

struct MapIcons {
    static let mapPin = "mappin.circle.fill" //generic
    static let mug = "mug" //pubs
    static let book = "book" // uni
    static let plug = "powerplug" // electric vehicles
    static let basket = "basket" // supermarket
    static let car = "car" // transport
}

struct ColorNames {
    static let goldColor = "goldColor"
    static let platinumColor = "platinumColor"
    static let silverColor = "silverColor"
    static let primary = "primary"
    static let secondary = "secondary"
}

struct TwitterAccounts {
    static let developer = "\(BaseUrl.twitter)Dave_iOSDev"
    static let aberCompSci = "\(BaseUrl.twitter)AberCompSci"
    static let iOSDevUK = "\(BaseUrl.twitter)iOSDevUK"
    static let digidol = "\(BaseUrl.twitter)digidol"
}

struct BaseUrl {
    static let twitter = "https://twitter.com/"
    static let linkedIn = "https://linkedIn.com/in/"
}
struct Slack {
    static let channelLink = "https://iosdevuk.slack.com"
}

struct FirebaseKeys {
    static let speakerIds = "speakerIds"
}

struct AppConstants {
    static let textViewHeight = 300.0
}
