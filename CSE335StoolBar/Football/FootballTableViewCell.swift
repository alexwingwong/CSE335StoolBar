//
//  FootballTableViewCell.swift
//  CSE335StoolBar
//
//  Created by Alexander Wong on 11/17/22.
//

import UIKit

class FootballTableViewCell: UITableViewCell {
    
    weak var game: Game?;

    @IBOutlet weak var GameTitle: UILabel!
    
    @IBOutlet weak var SpreadTeam1: UIButton!
    @IBOutlet weak var SpreadTeam2: UIButton!
    
    @IBOutlet weak var MoneyTeam1: UIButton!
    @IBOutlet weak var MoneyTeam2: UIButton!
    
    @IBOutlet weak var TotalOver: UIButton!
    @IBOutlet weak var TotalUnder: UIButton!
    
    func setGame(game: Game){
        self.game = game;
        GameTitle.text = game.team1 + " VS " + game.team2;
        SpreadTeam1.setTitle(game.spreadString1, for: .normal);
        SpreadTeam2.setTitle(game.spreadString2, for: .normal);
        MoneyTeam1.setTitle(game.moneyString1, for: .normal);
        MoneyTeam2.setTitle(game.moneyString2, for: .normal);
        TotalOver.setTitle(game.overString, for: .normal);
        TotalUnder.setTitle(game.underString, for: .normal);
        
        SpreadTeam1.addTarget(self, action: #selector(spread1Button(_:)), for: .touchUpInside);
        SpreadTeam2.addTarget(self, action: #selector(spread2Button(_:)), for: .touchUpInside);
        MoneyTeam1.addTarget(self, action: #selector(spread1Button(_:)), for: .touchUpInside);
        MoneyTeam2.addTarget(self, action: #selector(spread2Button(_:)), for: .touchUpInside);
        TotalOver.addTarget(self, action: #selector(spread1Button(_:)), for: .touchUpInside);
        TotalUnder.addTarget(self, action: #selector(spread2Button(_:)), for: .touchUpInside);

    }
    
    @objc func spread1Button(_ sender:UIButton!){
        print(game?.spreadString1);
    }
    
    @objc func spread2Button(_ sender:UIButton!){
        print(game?.spreadString2)
    }
    
    @objc func money1Button(_ sender:UIButton!){
        print(game?.moneyString1);
    }
    
    @objc func money2Button(_ sender:UIButton!){
        print(game?.moneyString2)
    }
    
    @objc func overButton(_ sender:UIButton!){
        print(game?.overString);
    }
    
    @objc func underButton(_ sender:UIButton!){
        print(game?.underString)
    }

}

