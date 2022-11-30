//
//  Game.swift
//  CSE335StoolBar
//
//  Created by Alexander Wong on 11/18/22.
//

import Foundation

class Game{
    
    var team1: String;
    var team2: String;
    var gameDateTime: String;
    
    var spreadOdds1: Double;
    var spreadOdds2: Double;
    var spreadString1: String;
    var spreadString2: String;
    
    var moneyOdds1: Double;
    var moneyOdds2: Double;
    var moneyString1: String;
    var moneyString2: String;
    
    var overOdds: Double;
    var underOdds: Double;
    var overString: String;
    var underString: String;
    
    init(Team1: String, Team2: String, GameDateTime: String, SpreadString1: String, SpreadString2: String, MoneyString1: String, MoneyString2: String, OverString: String, UnderString: String, SpreadOdds1: Double, SpreadOdds2: Double, MoneyOdds1: Double, MoneyOdds2: Double, OverOdds: Double, UnderOdds: Double ){
        team1 = Team1;
        team2 = Team2;
        gameDateTime = GameDateTime;
        spreadString1 = SpreadString1;
        spreadString2 = SpreadString2;
        moneyString1 = MoneyString1;
        moneyString2 = MoneyString2;
        overString = OverString;
        underString = UnderString;
        spreadOdds1 = SpreadOdds1;
        spreadOdds2 = SpreadOdds2;
        moneyOdds1 = MoneyOdds1;
        moneyOdds2 = MoneyOdds2;
        overOdds = OverOdds;
        underOdds = UnderOdds;
    }
}

