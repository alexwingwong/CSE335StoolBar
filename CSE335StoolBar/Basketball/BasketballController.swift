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

class BasketballController: UIViewController{

    var games: [Game] = [];
    static private var wagerAmount: String = "";
    @IBOutlet weak var BasketballTableView: UITableView!
    @IBAction func setWagerAmount(_ sender: UITextField) {
        print(sender.text);
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
        let g1 = Game(Team1: "PHX", Team2: "DAL", GameDateTime: "10PM", SpreadString1: "BUF -1.5, -102", SpreadString2: "KC +1.5, -128", MoneyString1: "BUF -120", MoneyString2: "KC -106", OverString: "O 20.5, -114", UnderString: "U 20.5, -114", SpreadOdds1: -102, SpreadOdds2: 128, MoneyOdds1: -120, MoneyOdds2: -106, OverOdds: -114, UnderOdds: -114)
        tempGames.append(g1);
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
