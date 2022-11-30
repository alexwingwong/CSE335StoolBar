//
//  BasketballGames.swift
//  CSE335StoolBar
//
//  Created by user224601 on 11/29/22.
//

import Foundation

struct Basketball: Decodable
{
    let get: String?
    let parameters: Parameters
    let errors: [String]?
    let results: Int?
    let response: [Response]
}

struct Parameters: Decodable
{
    let league: String?
    let season: String?
    let bookmaker: String?
}

struct Response: Decodable
{
    let league: League
    let country: Country
    let game: BGame
    let bookmakers: [Bookmakers]
}

struct Bookmakers: Decodable
{
    let id: Int?
    let name: String?
    let bets: [Bets]
}

struct Bets: Decodable
{
    let id: Int?
    let name: String?
    let values: [Values]
}

struct Values: Decodable
{
    let value: String?
    let odd: String?
}

struct League: Decodable
{
    let id: Int?
    let name: String?
    let type: String?
    let season: String?
    let logo: String?
}

struct Country: Decodable
{
    let id: Int?
    let name: String?
    let code: String?
    let flag: String?
}

struct BGame: Decodable
{
    let id: Int?
    let date: String?
    let time: String?
    let timestamp: Int?
    let timezone: String?
    let stage: String?
    let week: String?
    let status: Status
    let league: League
    let country: Country
    let teams: Teams
    let scores: Scores
}

struct Scores: Decodable
{
    let home: HomeScores
    let away: HomeScores
}

struct HomeScores: Decodable
{
    let quarter_1: Int?
    let quarter_2: Int?
    let quarter_3: Int?
    let quarter_4: Int?
    let over_time: Int?
    let total: Int?
}

struct Status: Decodable
{
    let long: String?
    let short: String?
    let timer: String?
}

struct Teams: Decodable
{
    let home: Home
    let away: Home
}

struct Home: Decodable
{
    let id: Int?
    let name: String?
    let logo: String?
}
