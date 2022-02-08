//
//  ViewController.swift
//  Test Restart
//
//  Created by user211441 on 2/8/22.
//

import UIKit
class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Outlets
    @IBOutlet weak var gameTable: UITableView!
    @IBOutlet weak var datePickerButton: UIButton!
    @IBOutlet weak var increaseDateButton: UIButton!
    @IBOutlet weak var decreaseDateButton: UIButton!
    @IBOutlet weak var cellButton: UIButton!
    
    let datePicker = UIDatePicker()
    let dateManager = DateManager()
    let urlString = "https://statsapi.mlb.com/api/v1/schedule?hydrate=team(league),venue(location,timezone),linescore&date=2018-09-19&sportId=1,51&language=en"
    
    var gameList: GameList?
    var currentDate = Date()
    var loadingView = UIView()
    
    // MARK: - Life Cycle Methods
    override func viewWillAppear(_ animated: Bool) {
        addLoadingView()
        gameTable.delegate = self
        gameTable.dataSource = self
        
        self.loadingView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        self.loadingView.backgroundColor = .white
        
        async {
            gameList = await NetworkManager().fetchData()
            self.gameTable.reloadData()
            removeLoadingView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.datePickerButton.setTitle(DateManager().dateString(date: self.currentDate), for: .normal)
        configureDatePicker()
    }
    
    // MARK: - Actions
    @IBAction func decreaseDate(_ sender: Any) {
        var dateComponent = DateComponents()
        dateComponent.day = -1
        self.currentDate = Calendar.current.date(byAdding: dateComponent, to: self.currentDate) ?? Date()
        self.datePickerButton.setTitle(DateManager().dateString(date: self.currentDate), for: .normal)
        dateSelected()
    }
    
    @IBAction func increaseDate(_ sender: Any) {
        var dateComponent = DateComponents()
        dateComponent.day = 1
        self.currentDate = Calendar.current.date(byAdding: dateComponent, to: self.currentDate) ?? Date()
        self.datePickerButton.setTitle(DateManager().dateString(date: self.currentDate), for: .normal)
        dateSelected()
    }
    
    @IBAction func showDatePicker(_ sender: Any) {
        self.view.addSubview(self.datePicker)
    }
    
    @IBAction func dateSelected() {
        self.datePickerButton.titleLabel?.text = DateManager().dateString(date: datePicker.date)
        async {
            gameList = await NetworkManager().updateDataFromDate(date: datePicker.date)
            self.gameTable.reloadData()
            removeLoadingView()
        }
        self.datePicker.removeFromSuperview()
        
    }

    @IBAction func cellButtonClicked(sender: UIButton) {
        
        var newViewController: SecondaryViewController
        newViewController = self.storyboard?.instantiateViewController(withIdentifier: "SecondViewController") as! SecondaryViewController
        newViewController.gameList = self.gameList
        newViewController.senderID = sender.tag
        self.present(newViewController, animated: true)
        
    }
    
    // MARK: - View Management
    func configureDatePicker() {
        self.datePicker.date = self.currentDate
        self.datePicker.locale = .current
        self.datePicker.datePickerMode = .date
        self.datePicker.preferredDatePickerStyle = .compact
        self.datePicker.addTarget(self, action: #selector(dateSelected), for: .valueChanged)
        self.datePicker.frame = CGRect(x: 10, y: 50, width: self.view.frame.width, height: 200)
    }

    func addLoadingView() {
        self.view.addSubview(self.loadingView)
    }
    
    func removeLoadingView() {
        self.loadingView.removeFromSuperview()
    }
    
    // MARK: - Table View Functions
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let gameList = self.gameList {
            return gameList.dates[0].games.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "gameCellType", for: indexPath) as? GameCell
        if let gameList = self.gameList {
            let game = gameList.dates[0].games[indexPath.row]
            
            cell?.homeTeamNameLabel.text = game.teams.home.team.name
            if let wins = game.teams.home.leagueRecord.wins as Int?, let loses = game.teams.home.leagueRecord.losses as Int? {
                cell?.homeTeamWinLossLabel.text =
                    String(wins) + " - " + String(loses)
            }
            if let score = game.teams.home.score as Int? {
                cell?.homeTeamScoreLabel.text = String(score)
            }
            
            cell?.awayTeamNameLabel.text = game.teams.away.team.name
            if let wins = game.teams.away.leagueRecord.wins as Int?,
                let loses = game.teams.away.leagueRecord.losses as Int?
            {
                cell?.awayTeamWinLossLabel.text =
                    String(wins) + " - " + String(loses)
            }
            if let score = game.teams.away.score as Int? {
                cell?.awayTeamScoreLabel.text = String(score)
            }
            cell?.gameStatusButton.titleLabel?.text = GameInterpreter().determineOvertime(game: game)
        }
        cell?.gameStatusButton.tag = indexPath.row
        if let nonNilCell = cell {
            nonNilCell.gameStatusButton.addTarget(self, action: #selector(cellButtonClicked), for: .touchUpInside)
        }
        
        if let gameCell = cell {
            return gameCell
        }
        return UITableViewCell()
    }
    
}
