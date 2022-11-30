//
//  FootballGames.swift
//  CSE335StoolBar
//
//  Created by user224601 on 11/25/22.
//

import Foundation

struct Outcome: Decodable {
    let name: String?
    let price: Double?
    let point: Double?
}
    
struct Market: Decodable {
    let key: String?
    let outcomes:[Outcome]
}
    
struct Bookmaker: Decodable {
    let key: String?
    let title: String?
    let last_update: String?
    let markets:[Market]
}
    
struct Games: Decodable {
    let id: String?
    let sport_key: String?
    let commence_time: String?
    let home_team: String?
    let away_team: String?
    let bookmakers:[Bookmaker]
}
