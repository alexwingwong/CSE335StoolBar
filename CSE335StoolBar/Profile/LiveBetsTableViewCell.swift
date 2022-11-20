//
//  LiveBetsTableViewCell.swift
//  CSE335StoolBar
//
//  Created by Alexander Wong on 11/18/22.
//
import UIKit
import Foundation

class LiveBetsTableViewCell: UITableViewCell{
    weak var bet: Bet?;
    
    @IBOutlet weak var BetText: UILabel!
    @IBOutlet weak var BetImage: UIImageView!
    
    func setBet(bet: Bet){
        self.bet = bet;
        let resultString: String = "\(bet.team1) vs. \(bet.team2), Bet: \(bet.betType), Amount Bet: \(bet.betAmount), Payout: \(bet.payout)";
        BetText.text = resultString;
        BetText.numberOfLines = 0;
        /*
        if(bet.betOver == true && bet.betWon == true){
            BetImage.image = UIImage(systemName: "checkmark.circle.fill")
        }
        else{
            BetImage.image = UIImage(systemName: "xmark.circle.fill")
        }
         */
    }
}
