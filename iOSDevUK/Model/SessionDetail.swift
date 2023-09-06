//
//  SessionDetail.swift
//  iOSDevUK
//
//  Created by David Kababyan on 06/09/2023.
//

import Foundation

struct SessionDetail: Hashable {
    let session: Session
    let speakers: [Speaker]
    let location: Location?
}
