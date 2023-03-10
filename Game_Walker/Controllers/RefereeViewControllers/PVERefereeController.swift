//
//  RefereeFrame2_1.swift
//  Game_Walker
//
//  Created by κΉνμ on 7/6/22.
//

import Foundation
import UIKit

class PVERefereeController: UIViewController {
    
    @IBOutlet weak var roundLabel: UILabel!
    @IBOutlet weak var scoreButton: UIButton!
    @IBOutlet weak var teamnameLabel: UILabel!
    @IBOutlet weak var teamscoreLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var ruleButton: UIButton!
    @IBOutlet weak var nextgameButton: UIButton!
    @IBOutlet weak var borderView: UIView!
    var round = 1
    var stationName = ""
    var index = 0
    var teamOrder : [Team] = []
    var timer: Timer?
    var seconds = 3600
    var time = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        H.delegate_getHost = self
        H.getHost(RefereeData.gamecode_save)
        S.delegate_getStation = self
        var team1 = Team(gamecode: RefereeData.gamecode_save, name: "Air", players: [], points: 20, currentStation: "testing", nextStation: "", iconName: "")
        var newStation = Station(name: "testing", pvp: true, points: 10, place: "", description: "", teamOrder: [team1])
        S.addStation(RefereeData.gamecode_save, newStation)
        S.getStation(RefereeData.gamecode_save, "testing")
        roundLabel.text = "Round 1"
        //scoreButton.setImage(UIImage(named: teamOrder[0].iconName), for: .normal)
        //teamnameLabel.text = teamOrder[0].name
        //teamscoreLabel.text = String(teamOrder[0].points)
        scoreButton.setImage(UIImage(named: "iconAir"), for: .normal)
        teamnameLabel.text = "Team 1"
        teamscoreLabel.text = "100"
        let myColor : UIColor = UIColor(red: 0.16, green: 0.82, blue: 0.44, alpha: 1.00)
        borderView.layer.borderColor = myColor.cgColor
        borderView.layer.borderWidth = 4.0
        timerLabel.text = ""
        runTimer()
    }
    
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(PVERefereeController.updateTimer)), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
            if seconds < 1 {
                self.timer?.invalidate()
            } else {
                seconds -= 1
                timerLabel.text = timeString(time: TimeInterval(seconds))
            }
    }
    
    func timeString(time:TimeInterval) -> String {
            let minutes = Int(time) / 60 % 60
            let seconds = Int(time) % 60
            return String(format:"%02i : %02i", minutes, seconds)
    }
    
    @IBAction func scoreButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "goToPVEScore", sender: self)
    }
    
    @IBAction func ruleButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "goToPVERule", sender: self)
    }
    
    @IBAction func nextgameButtonPressed(_ sender: UIButton) {
        round += 1
        roundLabel.text = "Round " + "\(round)"
        index += 1
        //scoreButton.setImage(UIImage(named: teamOrder[index].iconName), for: .normal)
        //teamnameLabel.text = teamOrder[index].name
        //teamscoreLabel.text = String(teamOrder[index].points)
        scoreButton.setImage(UIImage(named: "iconBear"), for: .normal)
        teamnameLabel.text = "GameWin"
        teamscoreLabel.text = String(1000)
    }
}

//MARK: - UIUpdate
extension PVERefereeController: GetStation {
    func getStation(_ station: Station) {
        self.stationName = station.name
        self.teamOrder = station.teamOrder
    }
}
//MARK: - UIUpdate
extension PVERefereeController: GetHost {
    func getHost(_ host: Host) {
        print(host.gameTime)
        self.seconds = host.gameTime
    }
}
