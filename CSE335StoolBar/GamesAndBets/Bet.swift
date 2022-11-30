//
//  Bet.swift
//  CSE335StoolBar
//
//  Created by Alexander Wong on 11/18/22.
//

import Foundation

class Bet{
    var team1: String;
    var team2: String;
    var gameDateTime: String; // include date !!
    
    var odds: Double;
    var betType: String;
    
    var betAmount: Double;
    var payout: Double;
    
    var betOver: Bool;
    var betWon: Bool;
    
    init(Team1: String, Team2: String, GameDateTime: String, Odds: Double, BetType:String, BetAmount: Double, Payout: Double, BetOver: Bool, BetWon: Bool){
        team1 = Team1;
        team2 = Team2;
        gameDateTime = GameDateTime;
        odds = Odds;
        betType = BetType;
        betAmount = BetAmount;
        payout = Payout;
        betOver = BetOver;
        betWon = BetWon;
    }
}
