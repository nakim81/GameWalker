//
//  StationsTableViewController.swift
//  Game_Walker
//
//  Created by Jin Kim on 8/18/22.
//

import UIKit

class StationsTableViewController: BaseViewController {
    
    var currentStations: [Station] = []
    //private var curr_gamecode = UserData.readGamecode("gamecodestring")
    var curr_gamecode = String(data: UserDefaults.standard.data(forKey: "gamecodestring")!, encoding: .utf8)!
    @IBOutlet weak var stationTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stationTable.register(UINib(nibName: "HostStationsTableViewCell", bundle: nil), forCellReuseIdentifier: "HostStationsTableViewCell")
        stationTable.delegate = self
        stationTable.dataSource = self
        S.delegate_stationList = self
        S.getStationList(curr_gamecode)
    }
    
    func reloadStationTable() {
        S.getStationList(curr_gamecode)
        self.stationTable.reloadData()
    }
    

}

extension StationsTableViewController: UITableViewDelegate {
    
}

extension StationsTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentStations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = stationTable.dequeueReusableCell(withIdentifier: "HostStationsTableViewCell", for: indexPath) as! HostStationsTableViewCell
        let curr_cellname = currentStations[indexPath.row].name
        cell.configureStationCell(stationName: curr_cellname)
        return cell
    }
    
    
}

extension StationsTableViewController: StationList {
    func listOfStations(_ stations: [Station]) {
        currentStations = stations
        reloadStationTable()
    }
    
}
