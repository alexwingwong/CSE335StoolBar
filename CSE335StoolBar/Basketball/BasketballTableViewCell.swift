//
//  BasketballTableViewCell.swift
//  CSE335StoolBar
//
//  Created by Alexander Wong on 11/17/22.
//

import UIKit

class BasketballTableViewCell: UITableViewCell {
    
    weak var game: BasketballGame?;

    @IBOutlet weak var GameTitle: UILabel!
    
    @IBOutlet weak var SpreadTeam1: UIButton!
    @IBOutlet weak var SpreadTeam2: UIButton!
    
    @IBOutlet weak var MoneyTeam1: UIButton!
    @IBOutlet weak var MoneyTeam2: UIButton!
    
    @IBOutlet weak var TotalTeam1: UIButton!
    @IBOutlet weak var TotalTeam2: UIButton!
    
    func setGame(game: BasketballGame){
        self.game = game;
        GameTitle.text = game.team1 + " VS " + game.team2;
        SpreadTeam1.setTitle(game.spreadOdds1, for: .normal);
        SpreadTeam2.setTitle(game.spreadOdds2, for: .normal);
        MoneyTeam1.setTitle(game.moneyOdds1, for: .normal);
        MoneyTeam2.setTitle(game.moneyOdds2, for: .normal);
        TotalTeam1.setTitle(game.overOdds, for: .normal);
        TotalTeam2.setTitle(game.underOdds, for: .normal);
        
        SpreadTeam1.addTarget(self, action: #selector(spread1Button(_:)), for: .touchUpInside);
        SpreadTeam2.addTarget(self, action: #selector(spread2Button(_:)), for: .touchUpInside);

    }
    
    @objc func spread1Button(_ sender:UIButton!){
        print(game?.spreadOdds1);
    }
    
    @objc func spread2Button(_ sender:UIButton!){
        print(game?.spreadOdds2)
    }

}

