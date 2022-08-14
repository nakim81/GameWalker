//
//  Team_Database.swift
//  Game_Walker
//
//  Created by Paul on 7/27/22.
//

import Foundation
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth
import FirebaseFirestoreSwift
import SwiftUI

struct T {
    static let db = Firestore.firestore()
    static var listener : ListenerRegistration?
    static var delegate_teamList: TeamList?
    static var delegate_getTeam: GetTeam?
    static var delegates : [TeamUpdateListener] = []
    

    static func readTeam(gamecode: String, onListenerUpdate: @escaping ([String : Any]) -> Void) {
        listener = db.collection("Servers").document("Gamecode : \(gamecode)").addSnapshotListener { documentSnapshot, error in
            guard let document = documentSnapshot else { return }
            guard let data = document.data() else { return }
            let team = convertDataToTeam(data)
            for delegate in delegates {
                delegate.updateTeam(team)
            }
        }
    }
    
    static func addTeam(_ gamecode: String, _ team: Team){
        let docRef = db.collection("Servers").document("Gamecode : \(gamecode)")
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                do {
                    try db.collection("\(gamecode) : Teams").document("\(team.name)").setData(from: team)
                    print("Team sucessfully saved")
                } catch let error {
                    print("Error writing to Firestore: \(error)")
                }
            } else {
                print("Gamecode does not exist")
            }
        }
    }
    
    static func removeTeam(_ gamecode: String, _ team: Team){
        db.collection("\(gamecode) : Teams").document(team.name).delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                print("Team Document successfully removed!")
            }
        }
    }
    
    static func joinTeam(_ gamecode: String, _ teamName: String, _ player: Player){
        let docRef = db.collection("\(gamecode) : Teams").document(teamName)
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                guard let data = document.data() else {return}
                var team = convertDataToTeam(data)
                team.players.append(player)
                //update team member
                updateTeam(gamecode, team)
            } else {
                print("Team does not exist")
            }
        }
    }
    
    static func givePoints(_ gamecode: String, _ teamName: String, _ points: Int){
        let docRef = db.collection("\(gamecode) : Teams").document(teamName)
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                guard let data = document.data() else {return}
                var team = convertDataToTeam(data)
                team.points += points
                updateTeam(gamecode, team)
            } else {
                print("Team does not exist")
            }
        }
    }

    static func getTeam(_ gamecode: String, _ teamName : String){
        let docRef = db.collection("\(gamecode) : Teams").document(teamName)
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                guard let data = document.data() else {return}
                let team = convertDataToTeam(data)
                delegate_getTeam?.getTeam(team)
            } else {
                print("Team does not exist")
            }
        }
    }
    
    static func getTeamList(_ gamecode: String){
        //Sorted by pvp, pve
        db.collection("\(gamecode) : Teams")
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    var teams : [Team] = []
                    for document in querySnapshot!.documents {
                        let data = document.data()
                        let team = convertDataToTeam(data)
                        teams.append(team)
                    }
                    delegate_teamList?.listOfTeams(teams)
                }
        }
    }
    
    static func updateTeam(_ gamecode: String, _ team: Team){
        do {
            try db.collection("\(gamecode) : Teams").document("\(team.name)").setData(from: team)
            print("Team sucessfully saved")
        } catch let error {
            print("Error writing to Firestore: \(error)")
        }
    }
    
    static func convertDataToTeam(_ data : [String : Any]) -> Team {
        do {
            //convert Dictionary data to JSON data first
            let json = try JSONSerialization.data(withJSONObject: data)
            //decode the JSON data to object
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let decoded = try decoder.decode(Team.self, from: json)
            return decoded
        } catch {
            print(error)
        }
        //blank team
        return Team(gamecode: "", name: "", players: [], points: 0, currentStation: "", nextStation: "", iconName: "")
     }
}

