//
//  BasketballGame.swift
//  CSE335StoolBar
//
//  Created by Alexander Wong on 11/17/22.
//

import Foundation

class BasketballGame{
    
    var team1: String;
    var team2: String;
    var time: String;
    
    var spreadOdds1: String;
    var spreadOdds2: String;
    
    var moneyOdds1: String;
    var moneyOdds2: String;
    
    var overOdds: String;
    var underOdds: String;
    
    init(t1: String, t2: String, timeString: String, so1: String, so2: String, mo1: String, mo2: String, oo: String, uo: String){
        team1 = t1;
        team2 = t2;
        time = timeString;
        spreadOdds1 = so1;
        spreadOdds2 = so2;
        moneyOdds1 = mo1;
        moneyOdds2 = mo2;
        overOdds = oo;
        underOdds = uo;
    }
    
}
