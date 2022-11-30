//
//  BasketballController.swift
//  CSE335StoolBar
//
//  Created by Alexander Wong on 11/17/22.
//

// used this video to implement table view:
// https://www.youtube.com/watch?v=FtO5QT2D_H8
    

import Foundation
import UIKit

class BasketballController: UIViewController
{
    var allBasketballGames:Basketball?
    var games: [Game] = []
    static private var wagerAmount: String = "";
    
    @IBOutlet weak var BasketballTableView: UITableView!
    @IBAction func setWagerAmount(_ sender: UITextField)
    {
        BasketballController.wagerAmount = sender.text ?? "no value";
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        games = initDummyData();
        
        BasketballTableView.delegate = self;
        BasketballTableView.dataSource = self;
    }
    
    func initDummyData() -> [Game]{
        var tempGames: [Game] = [];
        let g1 = Game(Team1: (allBasketballGames?.response[0].game.teams.home.name)!,
                      Team2: (allBasketballGames?.response[0].game.teams.away.name)!,
                      GameDateTime: (allBasketballGames?.response[0].game.date)!,
                      SpreadString1: "\((allBasketballGames?.response[0].bookmakers[0].bets[2].values[0].value)!), \((allBasketballGames?.response[0].bookmakers[0].bets[2].values[0].odd)!)",
                      SpreadString2: "\((allBasketballGames?.response[0].bookmakers[0].bets[2].values[1].value)!), \((allBasketballGames?.response[0].bookmakers[0].bets[2].values[1].odd)!)",
                      MoneyString1: "\((allBasketballGames?.response[0].game.teams.home.name)!), \((allBasketballGames?.response[0].bookmakers[0].bets[1].values[0].odd)!)",
                      MoneyString2: "\((allBasketballGames?.response[0].game.teams.away.name)!), \((allBasketballGames?.response[0].bookmakers[0].bets[1].values[1].odd)!)",
                      OverString: "\((allBasketballGames?.response[0].bookmakers[0].bets[3].values[0].value)!), \((allBasketballGames?.response[0].bookmakers[0].bets[3].values[0].odd)!)",
                      UnderString: "\((allBasketballGames?.response[0].bookmakers[0].bets[3].values[1].value)!), \((allBasketballGames?.response[0].bookmakers[0].bets[3].values[1].odd)!)",
                      SpreadOdds1: Double((allBasketballGames?.response[0].bookmakers[0].bets[2].values[0].odd)!)!,
                      SpreadOdds2: Double((allBasketballGames?.response[0].bookmakers[0].bets[2].values[1].odd)!)!,
                      MoneyOdds1: Double((allBasketballGames?.response[0].bookmakers[0].bets[1].values[0].odd)!)!,
                      MoneyOdds2: Double((allBasketballGames?.response[0].bookmakers[0].bets[1].values[1].odd)!)!,
                      OverOdds: Double((allBasketballGames?.response[0].bookmakers[0].bets[3].values[0].odd)!)!,
                      UnderOdds: Double((allBasketballGames?.response[0].bookmakers[0].bets[3].values[1].odd)!)!)
        let g2 = Game(Team1: (allBasketballGames?.response[1].game.teams.home.name)!,
                      Team2: (allBasketballGames?.response[1].game.teams.away.name)!,
                      GameDateTime: (allBasketballGames?.response[1].game.date)!,
                      SpreadString1: "\((allBasketballGames?.response[1].bookmakers[0].bets[2].values[0].value)!), \((allBasketballGames?.response[1].bookmakers[0].bets[2].values[0].odd)!)",
                      SpreadString2: "\((allBasketballGames?.response[1].bookmakers[0].bets[2].values[1].value)!), \((allBasketballGames?.response[1].bookmakers[0].bets[2].values[1].odd)!)",
                      MoneyString1: "\((allBasketballGames?.response[1].game.teams.home.name)!), \((allBasketballGames?.response[0].bookmakers[0].bets[1].values[0].odd)!)",
                      MoneyString2: "\((allBasketballGames?.response[1].game.teams.away.name)!), \((allBasketballGames?.response[0].bookmakers[0].bets[1].values[1].odd)!)",
                      OverString: "\((allBasketballGames?.response[1].bookmakers[0].bets[3].values[0].value)!), \((allBasketballGames?.response[1].bookmakers[0].bets[3].values[0].odd)!)",
                      UnderString: "\((allBasketballGames?.response[1].bookmakers[0].bets[3].values[1].value)!), \((allBasketballGames?.response[1].bookmakers[0].bets[3].values[1].odd)!)",
                      SpreadOdds1: Double((allBasketballGames?.response[1].bookmakers[0].bets[2].values[0].odd)!)!,
                      SpreadOdds2: Double((allBasketballGames?.response[1].bookmakers[0].bets[2].values[1].odd)!)!,
                      MoneyOdds1: Double((allBasketballGames?.response[1].bookmakers[0].bets[1].values[0].odd)!)!,
                      MoneyOdds2: Double((allBasketballGames?.response[1].bookmakers[0].bets[1].values[1].odd)!)!,
                      OverOdds: Double((allBasketballGames?.response[1].bookmakers[0].bets[3].values[0].odd)!)!,
                      UnderOdds: Double((allBasketballGames?.response[1].bookmakers[0].bets[3].values[1].odd)!)!)
        let g3 = Game(Team1: (allBasketballGames?.response[2].game.teams.home.name)!,
                      Team2: (allBasketballGames?.response[2].game.teams.away.name)!,
                      GameDateTime: (allBasketballGames?.response[2].game.date)!,
                      SpreadString1: "\((allBasketballGames?.response[2].bookmakers[0].bets[2].values[0].value)!), \((allBasketballGames?.response[2].bookmakers[0].bets[2].values[0].odd)!)",
                      SpreadString2: "\((allBasketballGames?.response[2].bookmakers[0].bets[2].values[1].value)!), \((allBasketballGames?.response[2].bookmakers[0].bets[2].values[1].odd)!)",
                      MoneyString1: "\((allBasketballGames?.response[2].game.teams.home.name)!), \((allBasketballGames?.response[0].bookmakers[0].bets[1].values[0].odd)!)",
                      MoneyString2: "\((allBasketballGames?.response[2].game.teams.away.name)!), \((allBasketballGames?.response[0].bookmakers[0].bets[1].values[1].odd)!)",
                      OverString: "\((allBasketballGames?.response[2].bookmakers[0].bets[3].values[0].value)!), \((allBasketballGames?.response[2].bookmakers[0].bets[3].values[0].odd)!)",
                      UnderString: "\((allBasketballGames?.response[2].bookmakers[0].bets[3].values[1].value)!), \((allBasketballGames?.response[2].bookmakers[0].bets[3].values[1].odd)!)",
                      SpreadOdds1: Double((allBasketballGames?.response[2].bookmakers[0].bets[2].values[0].odd)!)!,
                      SpreadOdds2: Double((allBasketballGames?.response[2].bookmakers[0].bets[2].values[1].odd)!)!,
                      MoneyOdds1: Double((allBasketballGames?.response[2].bookmakers[0].bets[1].values[0].odd)!)!,
                      MoneyOdds2: Double((allBasketballGames?.response[2].bookmakers[0].bets[1].values[1].odd)!)!,
                      OverOdds: Double((allBasketballGames?.response[2].bookmakers[0].bets[3].values[0].odd)!)!,
                      UnderOdds: Double((allBasketballGames?.response[2].bookmakers[0].bets[3].values[1].odd)!)!)
        tempGames.append(g1)
        tempGames.append(g2)
        tempGames.append(g3)
        return tempGames;
    }
    
    static func getWagerAmountText() -> String{
        return wagerAmount;
    }
}

extension BasketballController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return games.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let game = games[indexPath.row];
        
        let cell = BasketballTableView.dequeueReusableCell(withIdentifier: "BasketballTableViewCell") as! BasketballTableViewCell
        
        cell.setGame(game: game);
        
        return cell;
    }
}
