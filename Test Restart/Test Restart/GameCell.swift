//
//  GameCell.swift
//  MLB Test
//
//  Created by user211441 on 2/5/22.
//

import Foundation
import UIKit

class GameCell: UITableViewCell
{

    @IBOutlet weak var awayTeamNameLabel: UILabel!
    @IBOutlet weak var awayTeamWinLossLabel: UILabel!
    @IBOutlet weak var awayTeamScoreLabel: UILabel!
    
    @IBOutlet weak var homeTeamNameLabel: UILabel!
    @IBOutlet weak var homeTeamScoreLabel: UILabel!
    @IBOutlet weak var homeTeamWinLossLabel: UILabel!
    
    @IBOutlet weak var gameStatusButton: UIButton!
    

}
