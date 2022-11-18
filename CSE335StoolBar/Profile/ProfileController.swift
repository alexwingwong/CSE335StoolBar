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
    }
    
    func initProfilePicture(){
        //let image = UIImage(named: "AlexDog");
        ProfilePicture.layer.borderWidth = 1.0
        ProfilePicture.layer.masksToBounds = false
        ProfilePicture.layer.borderColor = UIColor.white.cgColor
        ProfilePicture.layer.cornerRadius = 128 / 2
        ProfilePicture.clipsToBounds = true
        

    }
}
