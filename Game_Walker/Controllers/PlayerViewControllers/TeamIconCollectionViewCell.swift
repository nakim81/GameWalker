//
//  IconCollectionViewCell.swift
//  Game_Walker
//
//  Created by Noah Kim on 6/17/22.
//

import UIKit

class TeamIconCollectionViewCell: UICollectionViewCell {
    
    private var imageView = UIImageView()
    private var imageName: String?
    private var teamNameLabel = UILabel()
    private let borderView = UIView(frame: CGRect(x: -5, y: -5, width: 70, height: 70))
    
    static let identifier = "IconCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        contentView.addSubview(imageView)
        contentView.addSubview(teamNameLabel)
        contentView.addSubview(borderView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
  
    func configureCreateTeamCell(_ imageName: String) {
        self.imageName = imageName
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 60).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        imageView.image = UIImage(named: imageName)
    }
    
    func configureJoinTeamCell(imageName: String, teamName: String) {
        self.imageName = imageName
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -15).isActive = true
        imageView.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor).isActive = true
        imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 1).isActive = true
        imageView.image = UIImage(named: imageName)
        teamNameLabel.clipsToBounds = true
        teamNameLabel.textAlignment = .center
        teamNameLabel.translatesAutoresizingMaskIntoConstraints = false
        teamNameLabel.text = teamName
        teamNameLabel.font = UIFont(name: "Dosis-Regular", size: 15)
        teamNameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        teamNameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10).isActive = true
        teamNameLabel.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor, constant: 2).isActive = true
        teamNameLabel.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor, constant: -2).isActive = true
        teamNameLabel.heightAnchor.constraint(equalTo: teamNameLabel.widthAnchor, multiplier: 0.35).isActive = true
    }
    
    func showBorder() {
        borderView.layer.borderColor = .init(red: 0, green: 0, blue: 0, alpha: 1)
        borderView.layer.borderWidth = 1
        borderView.layer.cornerRadius = borderView.layer.bounds.width / 2
    }
    
    func hideBorder() {
        borderView.layer.borderWidth = 0
    }
}
