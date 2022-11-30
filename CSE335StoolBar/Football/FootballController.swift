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
    
    @IBAction func setWagerAmount(_ sender: UITextField)
    {
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
            Team1: allFootballGames?[0].away_team ?? "Away Team",
            Team2: allFootballGames?[0].home_team ?? "Home Team",
            GameDateTime: allFootballGames?[0].commence_time ?? "Time",
            SpreadString1: "\((allFootballGames?[0].bookmakers[0].markets[1].outcomes[0].name)!) \((allFootballGames?[0].bookmakers[0].markets[1].outcomes[0].point)!), \((allFootballGames?[0].bookmakers[0].markets[1].outcomes[0].price)!)",
            SpreadString2: "\((allFootballGames?[0].bookmakers[0].markets[1].outcomes[1].name)!) \((allFootballGames?[0].bookmakers[0].markets[1].outcomes[1].point)!), \((allFootballGames?[0].bookmakers[0].markets[1].outcomes[1].price)!)",
            MoneyString1: "\((allFootballGames?[0].bookmakers[0].markets[0].outcomes[0].name)!), \((allFootballGames?[0].bookmakers[0].markets[0].outcomes[0].price)!)",
            MoneyString2: "\((allFootballGames?[0].bookmakers[0].markets[0].outcomes[1].name)!), \((allFootballGames?[0].bookmakers[0].markets[0].outcomes[1].price)!)",
            OverString: "\((allFootballGames?[0].bookmakers[0].markets[2].outcomes[0].name)!), \((allFootballGames?[0].bookmakers[0].markets[2].outcomes[0].point)!), \((allFootballGames?[0].bookmakers[0].markets[2].outcomes[0].price)!)",
            UnderString: "\((allFootballGames?[0].bookmakers[0].markets[2].outcomes[1].name)!), \((allFootballGames?[0].bookmakers[0].markets[2].outcomes[1].point)!), \((allFootballGames?[0].bookmakers[0].markets[2].outcomes[1].price)!)",
            SpreadOdds1: (allFootballGames?[0].bookmakers[0].markets[1].outcomes[0].price)!,
            SpreadOdds2: (allFootballGames?[0].bookmakers[0].markets[1].outcomes[1].price)!,
            MoneyOdds1: (allFootballGames?[0].bookmakers[0].markets[0].outcomes[0].price)!,
            MoneyOdds2: (allFootballGames?[0].bookmakers[0].markets[0].outcomes[1].price)!,
            OverOdds: (allFootballGames?[0].bookmakers[0].markets[2].outcomes[0].price)!,
            UnderOdds: (allFootballGames?[0].bookmakers[0].markets[2].outcomes[1].price)!)
        let g2 = Game(
            Team1: allFootballGames?[1].away_team ?? "Away Team",
            Team2: allFootballGames?[1].home_team ?? "Home Team",
            GameDateTime: allFootballGames?[1].commence_time ?? "Time",
            SpreadString1: "\((allFootballGames?[1].bookmakers[0].markets[1].outcomes[0].name)!) \((allFootballGames?[1].bookmakers[0].markets[1].outcomes[0].point)!), \((allFootballGames?[1].bookmakers[0].markets[1].outcomes[0].price)!)",
            SpreadString2: "\((allFootballGames?[1].bookmakers[0].markets[1].outcomes[1].name)!) \((allFootballGames?[1].bookmakers[0].markets[1].outcomes[1].point)!), \((allFootballGames?[1].bookmakers[0].markets[1].outcomes[1].price)!)",
            MoneyString1: "\((allFootballGames?[1].bookmakers[0].markets[0].outcomes[0].name)!), \((allFootballGames?[1].bookmakers[0].markets[0].outcomes[0].price)!)",
            MoneyString2: "\((allFootballGames?[1].bookmakers[0].markets[0].outcomes[1].name)!), \((allFootballGames?[1].bookmakers[0].markets[0].outcomes[1].price)!)",
            OverString: "\((allFootballGames?[1].bookmakers[0].markets[2].outcomes[0].name)!), \((allFootballGames?[1].bookmakers[0].markets[2].outcomes[0].point)!), \((allFootballGames?[1].bookmakers[0].markets[2].outcomes[0].price)!)",
            UnderString: "\((allFootballGames?[1].bookmakers[0].markets[2].outcomes[1].name)!), \((allFootballGames?[1].bookmakers[0].markets[2].outcomes[1].point)!), \((allFootballGames?[1].bookmakers[0].markets[2].outcomes[1].price)!)",
            SpreadOdds1: (allFootballGames?[1].bookmakers[0].markets[1].outcomes[0].price)!,
            SpreadOdds2: (allFootballGames?[1].bookmakers[0].markets[1].outcomes[1].price)!,
            MoneyOdds1: (allFootballGames?[1].bookmakers[0].markets[0].outcomes[0].price)!,
            MoneyOdds2: (allFootballGames?[1].bookmakers[0].markets[0].outcomes[1].price)!,
            OverOdds: (allFootballGames?[1].bookmakers[0].markets[2].outcomes[0].price)!,
            UnderOdds: (allFootballGames?[1].bookmakers[0].markets[2].outcomes[1].price)!)
        let g3 = Game(
            Team1: allFootballGames?[2].away_team ?? "Away Team",
            Team2: allFootballGames?[2].home_team ?? "Home Team",
            GameDateTime: allFootballGames?[2].commence_time ?? "Time",
            SpreadString1: "\((allFootballGames?[2].bookmakers[2].markets[1].outcomes[0].name)!) \((allFootballGames?[2].bookmakers[2].markets[1].outcomes[0].point)!), \((allFootballGames?[2].bookmakers[2].markets[1].outcomes[0].price)!)",
            SpreadString2: "\((allFootballGames?[2].bookmakers[2].markets[1].outcomes[1].name)!) \((allFootballGames?[2].bookmakers[2].markets[1].outcomes[1].point)!), \((allFootballGames?[2].bookmakers[2].markets[1].outcomes[1].price)!)",
            MoneyString1: "\((allFootballGames?[2].bookmakers[2].markets[0].outcomes[0].name)!), \((allFootballGames?[2].bookmakers[2].markets[0].outcomes[0].price)!)",
            MoneyString2: "\((allFootballGames?[2].bookmakers[2].markets[0].outcomes[1].name)!), \((allFootballGames?[2].bookmakers[2].markets[0].outcomes[1].price)!)",
            OverString: "\((allFootballGames?[2].bookmakers[2].markets[2].outcomes[0].name)!), \((allFootballGames?[2].bookmakers[2].markets[2].outcomes[0].point)!), \((allFootballGames?[2].bookmakers[2].markets[2].outcomes[0].price)!)",
            UnderString: "\((allFootballGames?[2].bookmakers[2].markets[2].outcomes[1].name)!), \((allFootballGames?[2].bookmakers[2].markets[2].outcomes[1].point)!), \((allFootballGames?[2].bookmakers[2].markets[2].outcomes[1].price)!)",
            SpreadOdds1: (allFootballGames?[2].bookmakers[2].markets[1].outcomes[0].price)!,
            SpreadOdds2: (allFootballGames?[2].bookmakers[2].markets[1].outcomes[1].price)!,
            MoneyOdds1: (allFootballGames?[2].bookmakers[2].markets[0].outcomes[0].price)!,
            MoneyOdds2: (allFootballGames?[2].bookmakers[2].markets[0].outcomes[1].price)!,
            OverOdds: (allFootballGames?[2].bookmakers[2].markets[2].outcomes[0].price)!,
            UnderOdds: (allFootballGames?[2].bookmakers[2].markets[2].outcomes[1].price)!)
        tempGames.append(g1);
        tempGames.append(g2)
        tempGames.append(g3)
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
