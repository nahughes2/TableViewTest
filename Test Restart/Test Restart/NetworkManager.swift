//
//  NetworkManager.swift
//  Test Restart
//
//  Created by user211441 on 2/8/22.
//

import Foundation
class NetworkManager {
    
    let urlString = "https://statsapi.mlb.com/api/v1/schedule?hydrate=team(league),venue(location,timezone),linescore&date=2018-09-19&sportId=1,51&language=en"
    
    // I know this function can be eliminated. In the interst of time,
    // I am leaving it here so the initial call to 09-19-2018 still works on start up.
    func fetchData() async -> GameList? {
        if let url = URL(string: urlString) {
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                var games = try JSONDecoder().decode(GameList.self, from: data)
                games.dates[0].games = sortGames(games: games)
                return games
            } catch {
                //TODO: Handle Error
                print(error)
                return nil
            }
        }
        return nil
    }
    
    func updateDataFromDate(date: Date) async -> GameList? {
        let simpleDate = DateManager().dateString(date: date)
        let urlWithNewDate = "https://statsapi.mlb.com/api/v1/schedule?hydrate=team(league),venue(location,timezone),linescore&date=\(simpleDate)&sportId=1,51&language=en"
        if let url = URL(string: urlWithNewDate) {
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                var games = try JSONDecoder().decode(GameList.self, from: data)
                games.dates[0].games = sortGames(games: games)
                return games
            } catch {
                //TODO: Handle Error
                print(error)
                return nil
            }
        }
        return nil
    }
    
    func sortGames(games: GameList) -> [Game] {
        return games.dates[0].games.sorted(by: {$0.gameDate > $1.gameDate})
    }
}
    
