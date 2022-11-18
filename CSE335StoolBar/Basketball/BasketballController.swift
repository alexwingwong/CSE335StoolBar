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

    @IBOutlet weak var BasketballTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        games = initDummyData();
        
        BasketballTableView.delegate = self;
        BasketballTableView.dataSource = self;
        
        
    }
    
    func initDummyData() -> [Game]{
        var tempGames: [Game] = [];
        
        let g1 = Game(t1: "PHX", t2: "BKN", timeString: "10PM", ss1: "+20, +150", ss2: "-20, -150", ms1: "Phx +215", ms2: "BKN -290", os: "O 125, -108", us: "U 125, +150", so1: 150.0, so2:-150.0, mo1: 215.0, mo2: -290.0, oo: -108, uo: +150);
        let g2 = Game(t1: "DAL", t2: "LAC", timeString: "10PM", ss1: "+20, +130", ss2: "-20, -130", ms1: "Phx +215", ms2: "BKN -290", os: "O 125, -108", us: "U 125, +150", so1: 150.0, so2:-150.0, mo1: 215.0, mo2: -290.0, oo: -108, uo: +150);
        let g3 = Game(t1: "PHX", t2: "BKN", timeString: "10PM", ss1: "+20, +150", ss2: "-20, -150", ms1: "Phx +215", ms2: "BKN -290", os: "O 125, -108", us: "U 125, +150", so1: 150.0, so2:-150.0, mo1: 215.0, mo2: -290.0, oo: -108, uo: +150);
        let g4 = Game(t1: "PHX", t2: "BKN", timeString: "10PM", ss1: "+20, +150", ss2: "-20, -150", ms1: "Phx +215", ms2: "BKN -290", os: "O 125, -108", us: "U 125, +150", so1: 150.0, so2:-150.0, mo1: 215.0, mo2: -290.0, oo: -108, uo: +150);
        
        tempGames.append(g1);
        tempGames.append(g2);
        tempGames.append(g3);
        tempGames.append(g4);
        
        return tempGames;
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
