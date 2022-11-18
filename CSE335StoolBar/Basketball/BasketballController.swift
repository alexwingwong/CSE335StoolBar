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

    var games: [BasketballGame] = [];
    

    @IBOutlet weak var BasketballTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        games = initDummyData();
        
        BasketballTableView.delegate = self;
        BasketballTableView.dataSource = self;
        
        
    }
    
    func initDummyData() -> [BasketballGame]{
        var tempGames: [BasketballGame] = [];
        
        let g1 = BasketballGame(t1: "PHX", t2: "BKN", timeString: "10PM", so1: "+20, +150", so2: "-20, -150", mo1: "Phx +215", mo2: "BKN -290", oo: "O 125, -108", uo: "U 125, +150");
        let g2 = BasketballGame(t1: "GSW", t2: "DAL", timeString: "8PM", so1: "+20, +150", so2: "-20, -150", mo1: "GSW +215", mo2: "DAL -290", oo: "O 125, -108", uo: "U 125, +150");
        let g3 = BasketballGame(t1: "GSW", t2: "DAL", timeString: "8PM", so1: "+20, +150", so2: "-20, -150", mo1: "GSW +215", mo2: "DAL -290", oo: "O 125, -108", uo: "U 125, +150");
        let g4 = BasketballGame(t1: "GSW", t2: "DAL", timeString: "8PM", so1: "+20, +150", so2: "-20, -150", mo1: "GSW +215", mo2: "DAL -290", oo: "O 125, -108", uo: "U 125, +150");
        
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
