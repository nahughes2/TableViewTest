//
//  SecondaryViewController.swift
//  Test Restart
//
//  Created by user211441 on 2/8/22.
//

import Foundation
import UIKit

class SecondaryViewController: UIViewController {
    
    var gameList: GameList?
    var senderID: Int = 0
    
    @IBOutlet weak var idLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        idLabel.text = String(senderID)
    }
    
    @IBAction func dismissButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
