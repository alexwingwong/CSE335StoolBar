//
//  BasketballTableViewCell.swift
//  CSE335StoolBar
//
//  Created by Alexander Wong on 11/17/22.
//

import UIKit

class BasketballTableViewCell: UITableViewCell {
    let db: SQLiteDatabase = try! SQLiteDatabase.open(path: dbPath!)
    
    weak var game: Game?;
    var betCount: Int = Int.random(in: 0...100000)

    @IBOutlet weak var GameTitle: UILabel!
    
    @IBOutlet weak var SpreadTeam1: UIButton!
    @IBOutlet weak var SpreadTeam2: UIButton!
    
    @IBOutlet weak var MoneyTeam1: UIButton!
    @IBOutlet weak var MoneyTeam2: UIButton!
    
    @IBOutlet weak var TotalOver: UIButton!
    @IBOutlet weak var TotalUnder: UIButton!
    
    func setGame(game: Game){
        self.game = game;
        GameTitle.text = game.team1 + " vs " + game.team2;
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
        if(game == nil){
            print("Error Creating Bet, game not found")
            return;
        }
        
        let betValue = getBetAmount();
        if(betValue == -1){
        print("Error: Invalid Bet Amount")
            return;
        }
        let betPayout = calcBetPayout(betAmount: betValue, odds: game!.spreadOdds1)
        let newBet = generateBet(inputgame: game!, inputOdds: game!.spreadOdds1, inputBetType: game!.spreadString1, inputBetAmount: betValue, inputBetPayout: betPayout)
        LiveBetsController.addBet(newBet: newBet);
        try! db.insertBet(bet: newBet)
    }
    
    @objc func spread2Button(_ sender:UIButton!){
        if(game == nil){
            print("Error Creating Bet, game not found");
            return;
        }
        
        let betValue = getBetAmount();
        if(betValue == -1){
            print("Error: Invalid Bet Amount");
            return;
        }
        let betPayout = calcBetPayout(betAmount: betValue, odds: game!.spreadOdds2)
        let newBet = generateBet(inputgame: game!, inputOdds: game!.spreadOdds2, inputBetType: game!.spreadString2, inputBetAmount: betValue, inputBetPayout: betPayout)
        LiveBetsController.addBet(newBet: newBet);
        try! db.insertBet(bet: newBet)
    }
    
    @objc func money1Button(_ sender:UIButton!){
        if(game == nil){
            print("Error Creating Bet, game not found");
            return;
        }
        
        let betValue = getBetAmount();
        if(betValue == -1){
            print("Error: Invalid Bet Amount");
            return;
        }
        let betPayout = calcBetPayout(betAmount: betValue, odds: game!.moneyOdds1)
        let newBet = generateBet(inputgame: game!, inputOdds: game!.moneyOdds1, inputBetType: game!.moneyString1, inputBetAmount: betValue, inputBetPayout: betPayout)
        LiveBetsController.addBet(newBet: newBet);
        try! db.insertBet(bet: newBet)
    }
    
    @objc func money2Button(_ sender:UIButton!){
        if(game == nil){
            print("Error Creating Bet, game not found");
            return;
        }
        let betValue = getBetAmount();
        if(betValue == -1){
            print("Error: Invalid Bet Amount");
            return;
        }
        let betPayout = calcBetPayout(betAmount: betValue, odds: game!.moneyOdds2)
        let newBet = generateBet(inputgame: game!, inputOdds: game!.moneyOdds2, inputBetType: game!.moneyString2, inputBetAmount: betValue, inputBetPayout: betPayout)
        LiveBetsController.addBet(newBet: newBet);
        try! db.insertBet(bet: newBet)
    }
    
    @objc func overButton(_ sender:UIButton!){
        if(game == nil){
            print("Error Creating Bet, game not found");
            return;
        }
        let betValue = getBetAmount();
        if(betValue == -1){
            print("Error: Invalid Bet Amount");
            return;
        }
        let betPayout = calcBetPayout(betAmount: betValue, odds: game!.overOdds)
        let newBet = generateBet(inputgame: game!, inputOdds: game!.overOdds, inputBetType: game!.overString, inputBetAmount: betValue, inputBetPayout: betPayout)
        LiveBetsController.addBet(newBet: newBet);
        try! db.insertBet(bet: newBet)
    }
    
    @objc func underButton(_ sender:UIButton!){
        if(game == nil){
            print("Error Creating Bet, game not found");
            return;
        }
        let betValue = getBetAmount();
        if(betValue == -1){
            print("Error: Invalid Bet Amount");
            return;
        }
        
        let betPayout = calcBetPayout(betAmount: betValue, odds: game!.underOdds)
        let newBet = generateBet(inputgame: game!, inputOdds: game!.underOdds, inputBetType: game!.underString, inputBetAmount: betValue, inputBetPayout: betPayout)
        LiveBetsController.addBet(newBet: newBet);
        try! db.insertBet(bet: newBet)
    }

    func calcBetPayout(betAmount: Double, odds: Double) -> Double
    {
        if(odds > 1 && odds < 99)
        {
            return odds * betAmount;
        }
        else if(odds < 0)
        {
            return (-1.0*100.0/odds * betAmount);
        }
        else
        {
            return (odds/100 * betAmount);
        }
    }
    
    func isStringADouble(wagerAmount: String) -> Bool{
        if Double(wagerAmount) != nil{
            return true;
        }
        else{
            return false;
        }
    }
    
    func getBetAmount() -> Double{
        let betValueString = BasketballController.getWagerAmountText();
        //print(betValueString)
        if(!isStringADouble(wagerAmount: betValueString)){ // if string is not a double
            print("invalid bet amount");
            return -1;
        }
        let betValue = Double(betValueString);
        if(betValue! < 0){
            print("cannot have a negative bet amount");
            return -1;
        }
        else{
            return betValue!;
        }
    }
    
    func generateBet(inputgame: Game, inputOdds: Double, inputBetType: String, inputBetAmount: Double, inputBetPayout: Double) -> Bet{
        let result = Bet(Team1: inputgame.team1, Team2: inputgame.team2, GameDateTime: inputgame.gameDateTime, Odds: inputOdds, BetType: inputBetType, BetAmount: inputBetAmount, Payout: inputBetPayout, BetOver: false, BetWon: false, ID: betCount);
        betCount = betCount + 1
        print(result.betID)
        return result;
    }
}

