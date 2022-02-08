//
//  GameInterpreter.swift
//  Test Restart
//
//  Created by user211441 on 2/8/22.
//

import Foundation

class GameInterpreter {
    
    func determineGameStatus(game: Game) -> CurrentStatus {
        let currentTime = Date()
        let gameDate = DateManager().getDateObject(game: game)
        // This is my best guess at determining current game status
        // I'm making some assumptions about what abstractGameState represents
        if currentTime > gameDate {
            // if now is later than game date
            if game.status.abstractGameState != "Final" {
                // if the game is not finished
                return  CurrentStatus.inProgress
                // must be in progress
                }
            return CurrentStatus.finished
            //other wise it is finished
        }
        return CurrentStatus.notStarted
        // game date is in the future
    }
    
    func determineOvertime(game: Game) -> String {
        let gameStatus = determineGameStatus(game: game)
        if gameStatus != CurrentStatus.notStarted {
            // in progress or finished
            if gameStatus != CurrentStatus.inProgress {
                // if finished count the innings
                if game.linescore.innings.count != 9 {
                    return "F/" + String(game.linescore.innings.count)
                }
                return "Final"
            }
            // in progress
            return "Current/" + String(game.linescore.currentInning)
            
        }
        
        let date = DateManager().getDateObject(game: game)
            
        return DateManager().convertTime(date: date)
    }}
