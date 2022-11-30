//
//  ProfileController.swift
//  CSE335StoolBar
//
//  Created by Alexander Wong on 11/17/22.
//

import Foundation
import UIKit

class ProfileController: UIViewController {

    @IBOutlet weak var ProfilePicture: UIImageView!
    @IBAction func BackButton(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initProfilePicture()
        downloadFootballJSON
        {
            //print("Success")
        }
        
        downloadBasketballJSON {
            //print("Success")
        }
    }
    
    func initProfilePicture(){
        //let image = UIImage(named: "AlexDog");
        ProfilePicture.layer.borderWidth = 1.0
        ProfilePicture.layer.masksToBounds = false
        ProfilePicture.layer.borderColor = UIColor.white.cgColor
        ProfilePicture.layer.cornerRadius = 128 / 2
        ProfilePicture.clipsToBounds = true
    }
    
    var footballItems:[Games]?
    var basketballItems:Basketball?
    func downloadFootballJSON(completed: @escaping () -> ())
    {
        let url = URL(string: "https://api.the-odds-api.com/v4/sports/americanfootball_nfl/odds?markets=h2h,spreads,totals&regions=us&oddsFormat=american&apiKey=ed6362c115b0e67994cea16c9be368dc")
            
        URLSession.shared.dataTask(with: url!) { data, response, err in
            if err == nil
            {
                do
                {
                    self.footballItems = try JSONDecoder().decode([Games].self, from: data!)
                    DispatchQueue.main.async
                    {
                        completed()
                    }
                }
                catch
                {
                    print("error fetching data from api")
                }
            }
        }.resume()
    }
    
    func downloadBasketballJSON(completed: @escaping () -> ())
    {
        let myURL = NSURL(string:"https://v1.basketball.api-sports.io/odds?league=12&season=2022-2023&bookmaker=1");
        let request = NSMutableURLRequest(url:myURL! as URL);
        request.addValue("c2d25bdb800ccdf3433f5e27ed49eefa", forHTTPHeaderField: "x-apisports-key")
        request.addValue("v1.basketball.api-sports.io", forHTTPHeaderField: "x-rapidapi-host")
               
        URLSession.shared.dataTask(with: request as URLRequest) { data, response, err in
            if err == nil
            {
                do
                {
                    self.basketballItems = try JSONDecoder().decode(Basketball.self, from: data!)
                    DispatchQueue.main.async
                    {
                        completed()
                    }
                }
                catch
                {
                    print("error fetching data from api")
                }
            }
        }.resume()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "Football"
        {
            let tabBarController = segue.destination as? FootballController
            tabBarController?.allFootballGames = footballItems
        }
        else if segue.identifier == "Basketball"
        {
            let tabBarController = segue.destination as? BasketballController
            tabBarController?.allBasketballGames = basketballItems
        }
    }
}
