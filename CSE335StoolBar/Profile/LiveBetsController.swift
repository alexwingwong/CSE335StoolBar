//
//  LiveBetsController.swift
//  CSE335StoolBar
//
//  Created by Alexander Wong on 11/17/22.
//

import Foundation
import UIKit

class LiveBetsController: UITableViewController {
    
    static var bets: [Bet] = [];
    
    @IBOutlet var LiveBetsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //LiveBetsController.bets = initDummyData();
        //LiveBetsController.delegate = self;
        //LiveBetsController.dataSource = self;
    }
    
    func initDummyData() -> [Bet]{
        var tempBets: [Bet] = [];
        let b1 = Bet(Team1: "PHX", Team2: "BNK", GameDateTime: "11/19/22 @10PM", Odds: 150, BetType: "PHX +20, +150", BetAmount: 10000, Payout: 15000, BetOver: false, BetWon: false);
        /*
        let b1 = Bet(t1: "PHX", t2: "BKN", timeString: "10PM", o: 150, betT: "PHX +20, +150", betA: 10000, p: 15000, bo: true, bw: true);
        let b2 = Bet(t1: "PHX", t2: "BKN", timeString: "10PM", o: 150, betT: "PHX +20, +150", betA: 10000, p: 15000, bo: false, bw: false);
        let b3 = Bet(t1: "PHX", t2: "BKN", timeString: "10PM", o: 150, betT: "PHX +20, +150", betA: 10000, p: 15000, bo: false, bw: false);
        let b4 = Bet(t1: "PHX", t2: "BKN", timeString: "10PM", o: 150, betT: "PHX +20, +150", betA: 10000, p: 15000, bo: false, bw: false);
        tempBets.append(b1);
        tempBets.append(b2);
        tempBets.append(b3);
        tempBets.append(b4);
        */
        tempBets.append(b1);
        return tempBets;
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return LiveBetsController.bets.count;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let bet = LiveBetsController.bets[indexPath.row];
        
        let cell = LiveBetsTableView.dequeueReusableCell(withIdentifier: "LiveBetsTableViewCell") as! LiveBetsTableViewCell
        
        cell.setBet(bet: bet);
        
        return cell;
    }
    
    static func addBet(newBet: Bet){
        //bets.append(newBet);
        LiveBetsController.bets.append(newBet);

    }
}
