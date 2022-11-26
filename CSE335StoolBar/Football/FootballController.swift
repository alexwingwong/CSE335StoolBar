//
//  FootballTableViewCell.swift
//  CSE335StoolBar
//
//  Created by Alexander Wong on 11/18/22.
//

import Foundation
import UIKit

class FootballController: UIViewController
{
    var allFootballGames:[Games]? //Games from the API
    
    var games: [Game] = []; //Games loaded into the TableView
    static private var wagerAmount: String = "";
    @IBOutlet weak var FootballTableView: UITableView!
    
    @IBAction func setWagerAmount(_ sender: UITextField) {
        print(sender.text)
        FootballController.wagerAmount = sender.text ?? "no value";
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        games = initDummyData();
        
        FootballTableView.delegate = self;
        FootballTableView.dataSource = self;
    }
    
    func initDummyData() -> [Game]{
        var tempGames: [Game] = [];
        let g1 = Game(
            Team1: allFootballGames?[1].away_team ?? "Away Team",
            Team2: allFootballGames?[1].home_team ?? "Home Team",
            GameDateTime: "10PM",
            SpreadString1: "BUF -1.5, -102",
            SpreadString2: "KC +1.5, -128",
            MoneyString1: "BUF -120",
            MoneyString2: "KC -106",
            OverString: "O 20.5, -114",
            UnderString: "U 20.5, -114",
            SpreadOdds1: (allFootballGames?[0].bookmakers[0].markets[1].outcomes[0].price)!,
            SpreadOdds2: (allFootballGames?[0].bookmakers[0].markets[1].outcomes[1].price)!,
            MoneyOdds1: (allFootballGames?[0].bookmakers[0].markets[0].outcomes[0].price)!,
            MoneyOdds2: (allFootballGames?[0].bookmakers[0].markets[0].outcomes[1].price)!,
            OverOdds: (allFootballGames?[0].bookmakers[0].markets[2].outcomes[0].price)!,
            UnderOdds: (allFootballGames?[0].bookmakers[0].markets[1].outcomes[1].price)!)
        tempGames.append(g1);
        return tempGames;
    }
    
    static func getWagerAmountText() -> String{
        return wagerAmount;
    }
}

extension FootballController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return games.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let game = games[indexPath.row];
        
        let cell = FootballTableView.dequeueReusableCell(withIdentifier: "FootballTableViewCell") as! FootballTableViewCell
        
        cell.setGame(game: game);
        
        return cell;
    }
}
