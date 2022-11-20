//
//  FootballTableViewCell.swift
//  CSE335StoolBar
//
//  Created by Alexander Wong on 11/17/22.
//

import UIKit

class FootballTableViewCell: UITableViewCell {
    
    static private var resultString:String = "";
    
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
            FootballTableViewCell.resultString = "Error Creating Bet, game not found";
            return;
        }
        
        let betValue = getBetAmount();
        if(betValue == -1){
            FootballTableViewCell.resultString = "Error: Invalid Bet Amount";
            return;
        }
        FootballTableViewCell.resultString = "Bet Added, \(game?.spreadString1)"
        let betPayout = calcBetPayout(betAmount: betValue, odds: game!.spreadOdds1)
        let newBet = generateBet(inputgame: game!, inputOdds: game!.spreadOdds1, inputBetType: game!.spreadString1, inputBetAmount: betValue, inputBetPayout: betPayout)
        LiveBetsController.addBet(newBet: newBet);
        print("added bet! \(String(describing: game?.spreadString1))")
    }
    
    @objc func spread2Button(_ sender:UIButton!){
        print("spread2")
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
        LiveBetsController.addBet(newBet: newBet);
    }
    
    @objc func money1Button(_ sender:UIButton!){
        print("money1")
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
        let newBet = generateBet(inputgame: game!, inputOdds: game!.moneyOdds1, inputBetType: game!.moneyString2, inputBetAmount: betValue, inputBetPayout: betPayout)
        LiveBetsController.addBet(newBet: newBet);
    }
    
    @objc func money2Button(_ sender:UIButton!){
        print("money2")
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
    }
    
    @objc func overButton(_ sender:UIButton!){
        print("over");
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
    }
    
    @objc func underButton(_ sender:UIButton!){
        print("under");
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
    }

    func calcBetPayout(betAmount: Double, odds: Double) -> Double{
        if(odds < 0){
            return (-1.0*100.0/odds * betAmount);
        }
        else{
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
        let betValueString = FootballController.getWagerAmountText();
        print(betValueString)
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
        let result = Bet(Team1: inputgame.team1, Team2: inputgame.team2, GameDateTime: inputgame.gameDateTime, Odds: inputOdds, BetType: inputBetType, BetAmount: inputBetAmount, Payout: inputBetPayout, BetOver: false, BetWon: false);
        return result;
    }
    
    // following this tutorial
    //https://www.youtube.com/watch?v=yVwQ7oWMxnk
    func showAlert(){
        let alert = UIAlertController(title: "Title", message: "Hello World", preferredStyle: .alert);
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: {action in
            print("tapped dismiss")
        }))
        //present(alert, animated: true);
    }
    func showActionSheet(){
        
    }
    
    static func getResultString() -> String{
        return FootballTableViewCell.resultString;
    }
}

