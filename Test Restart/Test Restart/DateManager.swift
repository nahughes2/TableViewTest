//
//  DateManager.swift
//  Test Restart
//
//  Created by user211441 on 2/8/22.
//

import Foundation

struct DateManager {
    
    func getDateObject(game: Game) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = dateFormatter.date(from: game.gameDate)
        if let dateObject = date {
            return  dateObject
        }
        return Date()
    }

    func getDateForNetwork(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        return dateFormatter.string(from: date)
        
    }

    func convertTime(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        
        return dateFormatter.string(from: date)
    }

    func dateString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        
        return dateFormatter.string(from: date)
        
    }
}
