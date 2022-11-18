//
//  LiveBetsController.swift
//  CSE335StoolBar
//
//  Created by Alexander Wong on 11/17/22.
//

import Foundation
import UIKit

class LiveBetsController: UITableViewController {
    
    var bets: [Bet] = [];
    
    @IBOutlet var LiveBetsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bets = initDummyData();
        //LiveBetsController.delegate = self;
        //LiveBetsController.dataSource = self;
    }
    
    func initDummyData() -> [Bet]{
        var tempBets: [Bet] = [];
        
        let b1 = Bet(t1: "PHX", t2: "BKN", timeString: "10PM", o: 150, betT: "PHX +20, +150", betA: 10000, p: 15000, bo: false, bw: false);
        let b2 = Bet(t1: "PHX", t2: "BKN", timeString: "10PM", o: 150, betT: "PHX +20, +150", betA: 10000, p: 15000, bo: false, bw: false);
        let b3 = Bet(t1: "PHX", t2: "BKN", timeString: "10PM", o: 150, betT: "PHX +20, +150", betA: 10000, p: 15000, bo: false, bw: false);
        let b4 = Bet(t1: "PHX", t2: "BKN", timeString: "10PM", o: 150, betT: "PHX +20, +150", betA: 10000, p: 15000, bo: false, bw: false);
        tempBets.append(b1);
        tempBets.append(b2);
        tempBets.append(b3);
        tempBets.append(b4);
        return tempBets;
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bets.count;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let bet = bets[indexPath.row];
        
        let cell = LiveBetsTableView.dequeueReusableCell(withIdentifier: "LiveBetsTableViewCell") as! LiveBetsTableViewCell
        
        cell.setBet(bet: bet);
        
        return cell;
    }
}
