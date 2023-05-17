//
//  Model.swift
//  HW-21-Kudaibergen_Temirlan
//
//  Created by Темирлан Кудайберген on 15.05.2023.
//

import Foundation

struct Cards: Decodable {
    var cards: [Card]
}

struct Card: Decodable {
    let cmc: Int?
    let name: String
    let text: String?
    let type: String?
    let rarity: String?
    let artist: String?
    let setName: String?
    let imageUrl: String?
    let manaCost: String?
}
