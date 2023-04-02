//
//  RSSFeed.swift
//  Driivz
//
//  Created by Or Chen on 01/04/2023.
//

import Foundation

struct RSSFeed: Codable {
    let channel: Channel

    struct Channel: Codable {
        let title: String
        let link: String
        let description: String
        let item: [Item]

        struct Item: Codable {
            let title: String
            let link: String
            let description: String
            let pubDate: String
            let guid: String
            let enclosure: Enclosure

            struct Enclosure: Codable {
                let url: String
                let length: String
                let type: String
            }
        }
    }
}
