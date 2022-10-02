//
//  WaitingController.swift
//  Game_Walker
//
//  Created by 김현식 on 9/17/22.
//

import Foundation
import UIKit

class WaitingController: BaseViewController {

    @IBOutlet weak var GameIconView: UIImageView!
    @IBOutlet weak var WaitingImageView: UIImageView!
    var assigned : Bool = false
    var pvp_check : Bool = false
    var station_name = ""
    var timer: Timer?
    var currentIndex: Int = 0
    var RegisterController: RegisterController?
    let waitingImagesArray = ["waiting 2.png", "waiting 1.png", "waiting. 1.png"]

    func startTimer() {
        if let timer = timer {
            self.timer = timer

        } else {
            Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { [self] timer in
                //let RegisterController = Game_Walker.RegisterController()
                //let WaitingController = WaitingController()
                //WaitingController.RegisterController = RegisterController
                R.getReferee(RefereeData.gamecode_save, RefereeData.referee_name)
                //print(RefereeData.gamecode_save)
                //print(RefereeData.referee_name)
                //self.getReferee(RefereeData.referee!)
                if self.currentIndex == 2 {
                    self.currentIndex = 0
                }
                else {
                    self.currentIndex = self.currentIndex + 1
                }
                //print(RefereeData.assigned)
                //print(RefereeData.station_name)
                self.WaitingImageView.image = UIImage(named: self.waitingImagesArray[self.currentIndex])
                if RefereeData.assigned {
                    //S.getStation(RefereeData.gamecode_save, RefereeData.station_name)
                    //if (RefereeData.station_name != "") {
                        stopTimer()
                        if RefereeData.pvp_check {
                            performSegue(withIdentifier: "goToPVP", sender: self)
                        }
                        else {
                            performSegue(withIdentifier: "goToPVE", sender: self)
                        }
                    //}
                }
            }
        }
    }

    func stopTimer() {
        self.timer?.invalidate()
        self.timer = nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        R.delegate_getReferee = self
        S.delegate_getStation = self
        startTimer()
        if assigned && (station_name != "") {
            stopTimer()
            if pvp_check {
                performSegue(withIdentifier: "goToPVP", sender: self)
            }
            else {
                performSegue(withIdentifier: "goToPVE", sender: self)
            }
        }
    }
}
//MARK: - UIUpdate
extension WaitingController: GetReferee {
    func getReferee(_ referee: Referee) {
        //print(referee.assigned)
        RefereeData.assigned = referee.assigned
        RefereeData.station_name = referee.stationName
        //print(RefereeData.assigned)
    }
}

//MARK: - UIUpdate
extension WaitingController: GetStation {
    func getStation(_ station: Station) {
        RefereeData.station_name = station.name
        RefereeData.pvp_check = station.pvp
    }
}
