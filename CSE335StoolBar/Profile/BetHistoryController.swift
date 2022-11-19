//
//  BetHistoryController.swift
//  CSE335StoolBar
//
//  Created by Alexander Wong on 11/19/22.
//

import Foundation
import UIKit

class BetHistoryController: UITableViewController {
    
    var bets: [Bet] = [];
    
    @IBOutlet var BetHistoryTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bets = initDummyData();
        //BetHistoryController.delegate = self;
        //BetHistoryController.dataSource = self;
    }
    
    func initDummyData() -> [Bet]{
        var tempBets: [Bet] = [];
        
        let b1 = Bet(t1: "PHX", t2: "BKN", timeString: "10PM", o: 150, betT: "PHX +20, +150, 69420", betA: 10000, p: 15000, bo: true, bw: true);
        let b2 = Bet(t1: "PHX", t2: "BKN", timeString: "10PM", o: 150, betT: "PHX +20, +150", betA: 10000, p: 15000, bo: false, bw: false);
        let b3 = Bet(t1: "PHX", t2: "BKN", timeString: "10PM", o: 150, betT: "PHX +20, +150", betA: 10000, p: 15000, bo: false, bw: false);
        let b4 = Bet(t1: "PHX", t2: "BKN", timeString: "10PM", o: 150, betT: "PHX +20, +150", betA: 10000, p: 15000, bo: false, bw: false);
        tempBets.append(b1);
        //tempBets.append(b2);
        //tempBets.append(b3);
        //tempBets.append(b4);
        return tempBets;
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bets.count;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let bet = bets[indexPath.row];
        
        let cell = BetHistoryTableView.dequeueReusableCell(withIdentifier: "BetHistoryTableViewCell") as! BetHistoryTableViewCell
        
        cell.setBet(bet: bet);
        
        return cell;
    }
}
