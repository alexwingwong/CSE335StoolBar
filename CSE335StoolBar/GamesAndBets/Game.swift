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
    var time: String;
    
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
    
    init(t1: String, t2: String, timeString: String, ss1: String, ss2: String, ms1: String, ms2: String, os: String, us: String, so1: Double, so2: Double, mo1: Double, mo2: Double, oo: Double, uo: Double ){
        team1 = t1;
        team2 = t2;
        time = timeString;
        spreadString1 = ss1;
        spreadString2 = ss2;
        moneyString1 = ms1;
        moneyString2 = ms2;
        overString = os;
        underString = us;
        spreadOdds1 = so1;
        spreadOdds2 = so2;
        moneyOdds1 = mo1;
        moneyOdds2 = mo2;
        overOdds = oo;
        underOdds = uo;
    }
}

