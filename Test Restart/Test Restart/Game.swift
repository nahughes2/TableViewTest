//
//  File.swift
//  MLB Test
//
//  Created by user211441 on 2/5/22.
//

import Foundation

struct GameList: Decodable {
    var dates: [GameDate]
}

struct GameDate: Decodable {
    var date = ""
    var games: [Game]
}

struct Game: Decodable {
    var status: Status
    var gameDate = "" //starting time
    var teams: Teams
    var linescore: LineScore
}

struct Status: Decodable {
    var abstractGameState = ""
    var overTime: Bool?
    
}

struct Teams: Decodable {
    var away: Team
    var home: Team
}

struct Team: Decodable {
    var leagueRecord: Record
    var score = 0
    var team: TeamID
}

struct Record: Decodable {
    var wins = 0
    var losses = 0
}

struct TeamID: Decodable {
    var name = ""

}

struct LineScore: Decodable {
    var currentInning = 0
    var innings: [Inning]
}

struct Inning: Decodable {
    var num = 0
}

struct GameStatus {
    
}

enum CurrentStatus {
    case notStarted
    case inProgress
    case finished
}
