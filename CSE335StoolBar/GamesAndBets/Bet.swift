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
    var time: String;
    
    var odds: Double;
    var betType: String;
    
    var betAmount: Double;
    var payout: Double;
    
    var betOver: Bool;
    var betWon: Bool;
    
    init(t1: String, t2: String, timeString: String, o: Double, betT:String, betA: Double, p: Double, bo: Bool, bw: Bool){
        team1 = t1;
        team2 = t2;
        time = timeString;
        odds = o;
        betType = betT;
        betAmount = betA;
        payout = p;
        betOver = bo;
        betWon = bw;
    }
}
