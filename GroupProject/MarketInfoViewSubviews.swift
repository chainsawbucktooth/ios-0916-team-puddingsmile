//
//  MarketInfoViewSubviews.swift
//  GroupProject
//
//  Created by Benjamin Su on 11/30/16.
//  Copyright © 2016 Alexander Mason. All rights reserved.
//
import MapKit
import Foundation
import UIKit
import MapKit

//MARK: - Create Subviews
extension MarketInfo: InfoTableDelegate, EditorBoxDelegate {
    
    func createObjects() {
        
        createMapView()
        createBlurView()
        createDetailView()
        createNameButtonView()
        createAddressButtonView()
        createcityButtonView()
        createSeasonButtonView()
        createDaysButtonView()
        createTimeButtonView()
        createEBTButtonView()
        createWebsiteButtonView()
        createEditorBox()
        createInfoTableView()
        createNavigationView()
        createBackButton()
        createEditButton()
        createFavoriteButton()
        createCommentsButton()
        
    }
    
    func createMapView() {
        
        mapView = MKMapView()
        self.addSubview(mapView)
        mapView.isUserInteractionEnabled = false
        mapView.layer.cornerRadius = 10
        
    }
    
    func createBlurView() {
        
        blurView = UIView()
        self.addSubview(blurView)
        blurView.isUserInteractionEnabled = false
        blurView.backgroundColor = UIColor.black
        blurView.alpha = 0.0
        
    }
    
    func createDetailView() {
        
        detailView = UIView()
        self.addSubview(detailView)
        detailView.backgroundColor = UIColor.themeSecondary
        detailView.layer.cornerRadius = 10
        
    }
    
    func createNameButtonView() {
        
        nameButton = UIButton()
        self.detailView.addSubview(nameButton)
        nameButton.isEnabled = false
//        nameButton.addTarget(self, action: #selector(editNameAction), for: .touchUpInside)
        
        nameLabel = UILabel()
        self.detailView.addSubview(nameLabel)
        nameLabel.backgroundColor = UIColor.themeSecondary
        nameLabel.text = "Name: \(market.name!)"
        nameLabel.font = Constants.themeFont()
        nameLabel.adjustsFontSizeToFitWidth = true
        
    }
    
    func createAddressButtonView() {
        
        addressButton = UIButton()
        self.detailView.addSubview(addressButton)
        addressButton.isEnabled = false
        addressButton.addTarget(self, action: #selector(editAddressAction), for: .touchUpInside)
        
        addressLabel = UILabel()
        self.detailView.addSubview(addressLabel)
        addressLabel.backgroundColor = UIColor.themeSecondary
        addressLabel.text = "Address: \(market.address!)"
        addressLabel.font = Constants.themeFont()
        addressLabel.adjustsFontSizeToFitWidth = true
        
    }
    
    func createcityButtonView() {
        
        cityButton = UIButton()
        self.detailView.addSubview(cityButton)
        cityButton.isEnabled = false
        cityButton.addTarget(self, action: #selector(editCityAction), for: .touchUpInside)
        
        cityLabel = UILabel()
        self.detailView.addSubview(cityLabel)
        cityLabel.backgroundColor = UIColor.themeSecondary
        cityLabel.text = "City: \(market.city!)"
        cityLabel.font = Constants.themeFont()
        
    }
    
    func createSeasonButtonView() {
        
        seasonButton = UIButton()
        self.detailView.addSubview(seasonButton)
        seasonButton.isEnabled = false
        seasonButton.addTarget(self, action: #selector(editSeasonAction), for: .touchUpInside)
        
        seasonLabel = UILabel()
        self.detailView.addSubview(seasonLabel)
        seasonLabel.backgroundColor = UIColor.themeSecondary
        seasonLabel.text = "Season: \(market.openDate!) - \(market.closeDate!)"
        seasonLabel.font = Constants.themeFont()
        
    }
    
    func createDaysButtonView() {
        
        daysButton = UIButton()
        self.detailView.addSubview(daysButton)
        daysButton.isEnabled = false
        daysButton.addTarget(self, action: #selector(editDaysAction), for: .touchUpInside)
        
        daysLabel = UILabel()
        self.detailView.addSubview(daysLabel)
        daysLabel.backgroundColor = UIColor.themeSecondary
        daysLabel.text = "Days Open: \(market.weekDayOpen!)"
        daysLabel.font = Constants.themeFont()
        
    }
    
    func createTimeButtonView() {
        
        timeButton = UIButton()
        self.detailView.addSubview(timeButton)
        timeButton.isEnabled = false
        timeButton.addTarget(self, action: #selector(editTimeAction), for: .touchUpInside)
        
        timeLabel = UILabel()
        self.detailView.addSubview(timeLabel)
        timeLabel.backgroundColor = UIColor.themeSecondary
        timeLabel.text = "Times Open: \(market.startTime!) - \(market.endTime!)"
        timeLabel.font = Constants.themeFont()
        
    }
    
    func createEBTButtonView() {
        
        ebtButton = UIButton()
        self.detailView.addSubview(ebtButton)
        ebtButton.isEnabled = false
        ebtButton.addTarget(self, action: #selector(editEBTAction), for: .touchUpInside)
        
        ebtLabel = UILabel()
        self.detailView.addSubview(ebtLabel)
        ebtLabel.backgroundColor = UIColor.themeSecondary
        ebtLabel.text = "Accept EBT - \(market.acceptEBT == "EBT" ? "True" : "False")"
        ebtLabel.font = Constants.themeFont()
        
    }
    
    func createWebsiteButtonView() {
        
        websiteButton = UIButton()
        self.detailView.addSubview(websiteButton)
        websiteButton.addTarget(self, action: #selector(startSafari), for: .touchUpInside)
        
        websiteLabel = UILabel()
        self.detailView.addSubview(websiteLabel)
        websiteLabel.backgroundColor = UIColor.themeSecondary
        websiteLabel.text = "Check out website"
        websiteLabel.textColor = UIColor.darkGray
        websiteLabel.font = Constants.themeFont()
        websiteLabel.textAlignment = .center
        
    }
    
    func createEditorBox() {
        
        editorBox = EditorBox(frame: CGRect(x: 0, y: self.bounds.height * -0.4, width: self.bounds.width, height: self.bounds.height * 0.38))
        editorBox.createObjects()
        editorBox.isHidden = true
        editorBox.delegate = self
        self.addSubview(editorBox)
        
    }
    
    func createInfoTableView() {
        
        infoTableView = InfoTableView(frame: CGRect(x: 0, y: self.bounds.height * -0.4, width: self.bounds.width, height: self.bounds.height * 0.38))
        infoTableView.setupInfoTableView(market: self.market)
        infoTableView.isHidden = true
        infoTableView.delegate = self
        self.addSubview(infoTableView)
        
    }
    
    func createNavigationView() {
        
        navigationView = UIView()
        self.addSubview(navigationView)
        navigationView.backgroundColor = UIColor.themeAccent1
        
    }
    
    func createBackButton() {
        
        backButton = UIButton()
        navigationView.addSubview(backButton)
        backButton.setImage(UIImage(named: "backIconPng"), for: .normal)
        backButton.addTarget(self, action: #selector(backButtonAction), for: .touchUpInside)
        
    }
    
    func createEditButton() {
        
        editButton = UIButton()
        navigationView.addSubview(editButton)
        editButton.setImage(UIImage(named: "editIcon"), for: .normal)
        editButton.addTarget(self, action: #selector(editButtonAction), for: .touchUpInside)
        editButton.layer.borderColor = UIColor.red.cgColor
        
    }
    
    func createFavoriteButton() {
        
        favoriteButton = UIButton()
        navigationView.addSubview(favoriteButton)
        favoriteButton.setImage(UIImage(named: "heartIcon"), for: .normal)
        favoriteButton.addTarget(self, action: #selector(favoriteButtonAction), for: .touchUpInside)
        FirebaseAPI.hasFavorited(marketName: market.name!, isTrue: { isTrue in
            
            if isTrue {
                
                self.favoriteButton.isUserInteractionEnabled = false
                self.favoriteButton.alpha = 0.5
                
            } else {
                
                self.favoriteButton.isUserInteractionEnabled = true
                
            }
        })
    }
    
    func createCommentsButton() {
        
        commentsButton = UIButton()
        navigationView.addSubview(commentsButton)
        commentsButton.setImage(UIImage(named: "commentImage"), for: .normal)
        commentsButton.addTarget(self, action: #selector(commentsButtonAction), for: .touchUpInside)
        
    }
    
}
