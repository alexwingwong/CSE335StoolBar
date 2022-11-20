//
//  BasketballTableViewCell.swift
//  CSE335StoolBar
//
//  Created by Alexander Wong on 11/17/22.
//

import UIKit

class BasketballTableViewCell: UITableViewCell {
    
    weak var game: Game?;

    @IBOutlet weak var GameTitle: UILabel!
    
    @IBOutlet weak var SpreadTeam1: UIButton!
    @IBOutlet weak var SpreadTeam2: UIButton!
    
    @IBOutlet weak var MoneyTeam1: UIButton!
    @IBOutlet weak var MoneyTeam2: UIButton!
    
    @IBOutlet weak var TotalOver: UIButton!
    @IBOutlet weak var TotalUnder: UIButton!
    
    func setGame(game: Game){
        self.game = game;
        GameTitle.text = game.team1 + " VS " + game.team2;
        SpreadTeam1.setTitle(game.spreadString1, for: .normal);
        SpreadTeam2.setTitle(game.spreadString2, for: .normal);
        MoneyTeam1.setTitle(game.moneyString1, for: .normal);
        MoneyTeam2.setTitle(game.moneyString2, for: .normal);
        TotalOver.setTitle(game.overString, for: .normal);
        TotalUnder.setTitle(game.underString, for: .normal);
        
        SpreadTeam1.addTarget(self, action: #selector(spread1Button(_:)), for: .touchUpInside);
        SpreadTeam2.addTarget(self, action: #selector(spread2Button(_:)), for: .touchUpInside);
        MoneyTeam1.addTarget(self, action: #selector(money1Button(_:)), for: .touchUpInside);
        MoneyTeam2.addTarget(self, action: #selector(money2Button(_:)), for: .touchUpInside);
        TotalOver.addTarget(self, action: #selector(overButton(_:)), for: .touchUpInside);
        TotalUnder.addTarget(self, action: #selector(underButton(_:)), for: .touchUpInside);

    }
    
    @objc func spread1Button(_ sender:UIButton!){
        print("spread1")
        if(game == nil){
            print("Error Creating Bet, game not found");
            return;
        }
        let betValue = 1000.0;
        let betPayout = calcBetPayout(betAmount: betValue, odds: game!.spreadOdds1)
        let newBet = Bet(Team1: game!.team1, Team2: game!.team2, GameDateTime: game!.gameDateTime, Odds: game!.spreadOdds1, BetType: game!.spreadString1, BetAmount: betValue, Payout: betPayout, BetOver: false, BetWon: false);
        LiveBetsController.addBet(newBet: newBet);
    }
    
    @objc func spread2Button(_ sender:UIButton!){
        print("spread2")
        if(game == nil){
            print("Error Creating Bet, game not found");
            return;
        }
        let betValue = 1000.0;
        let betPayout = calcBetPayout(betAmount: betValue, odds: game!.spreadOdds2)
        let newBet = Bet(Team1: game!.team1, Team2: game!.team2, GameDateTime: game!.gameDateTime, Odds: game!.spreadOdds2, BetType: game!.spreadString2, BetAmount: betValue, Payout: betPayout, BetOver: false, BetWon: false);
        LiveBetsController.addBet(newBet: newBet);
    }
    
    @objc func money1Button(_ sender:UIButton!){
        print("money1")
        if(game == nil){
            print("Error Creating Bet, game not found");
            return;
        }
        let betValue = 1000.0;
        let betPayout = calcBetPayout(betAmount: betValue, odds: game!.moneyOdds1);
        let newBet = Bet(Team1: game!.team1, Team2: game!.team2, GameDateTime: game!.gameDateTime, Odds: game!.moneyOdds1, BetType: game!.moneyString1, BetAmount: betValue, Payout: betPayout, BetOver: false, BetWon: false);
        LiveBetsController.addBet(newBet: newBet);
    }
    
    @objc func money2Button(_ sender:UIButton!){
        print("money2")
        if(game == nil){
            print("Error Creating Bet, game not found");
            return;
        }
        let betValue = 1000.0;
        let betPayout = calcBetPayout(betAmount: betValue, odds: game!.moneyOdds2);
        let newBet = Bet(Team1: game!.team1, Team2: game!.team2, GameDateTime: game!.gameDateTime, Odds: game!.moneyOdds2, BetType: game!.moneyString2, BetAmount: betValue, Payout: betPayout, BetOver: false, BetWon: false);
        LiveBetsController.addBet(newBet: newBet);
    }
    
    @objc func overButton(_ sender:UIButton!){
        print("over");
        if(game == nil){
            print("Error Creating Bet, game not found");
            return;
        }
        let betValue = 1000.0;
        let betPayout = calcBetPayout(betAmount: betValue, odds: game!.overOdds);
        let newBet = Bet(Team1: game!.team1, Team2: game!.team2, GameDateTime: game!.gameDateTime, Odds: game!.overOdds, BetType: game!.overString, BetAmount: betValue, Payout: betPayout, BetOver: false, BetWon: false);
        LiveBetsController.addBet(newBet: newBet);
    }
    
    @objc func underButton(_ sender:UIButton!){
        print("under");
        if(game == nil){
            print("Error Creating Bet, game not found");
            return;
        }
        let betValue = 1000.0;
        let betPayout = calcBetPayout(betAmount: betValue, odds: game!.underOdds);
        let newBet = Bet(Team1: game!.team1, Team2: game!.team2, GameDateTime: game!.gameDateTime, Odds: game!.underOdds, BetType: game!.underString, BetAmount: betValue, Payout: betPayout, BetOver: false, BetWon: false);
        LiveBetsController.addBet(newBet: newBet);
    }

    func calcBetPayout(betAmount: Double, odds: Double) -> Double{
        return (odds/100 * betAmount);
    }
}

