//
//  ProfileModel.swift
//  CSE335StoolBar
//
//  Created by Alexander Wong on 11/19/22.
//

import Foundation

class Profile{
    var firstName: String;
    var lastName: String;
    
    var betsWon: Int;
    var betsLost: Int;
    
    var totalWinnings: Double;
    var totalLosses: Double;
    var netGains: Double;
    
    init(FirstName: String, LastName: String, BetsWon: Int, BetsLost: Int, TotalWinnings: Double, TotalLosses: Double, NetGains: Double){
        firstName = FirstName;
        lastName = LastName;
        betsWon = BetsWon;
        betsLost = BetsLost;
        totalWinnings = TotalWinnings;
        totalLosses = TotalLosses;
        netGains = NetGains;
    }
}
