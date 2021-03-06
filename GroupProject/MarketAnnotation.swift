
//
//  MarketAnnotation.swift
//  GroupProject
//
//  Created by Alexander Mason on 11/23/16.
//  Copyright © 2016 Alexander Mason. All rights reserved.
//

import Foundation
import MapKit

class MarketAnnotation: NSObject, MKAnnotation {
    
    var market: Market!
    var title: String?
    var subtitle: String?
    var coordinate: CLLocationCoordinate2D
    
    init(market: Market) {
        self.market = market
        self.title = market.name
        self.subtitle = market.address
        
        let latitude = Double(market.latitude!)
        let longitude = Double(market.longitude!)
        
        self.coordinate = CLLocationCoordinate2D(latitude: latitude!, longitude: longitude!)
    }
    
}

class AddMarketAnnotation: NSObject, MKAnnotation {
    
    var market: AddMarket!
    var title: String?
    var subtitle: String?
    var coordinate: CLLocationCoordinate2D
    
    init(market: AddMarket) {
        self.market = market
        self.title = market.marketName
        self.subtitle = market.address
        
        let latitude = Double(market.latitude!)
        let longitude = Double(market.longitude!)
        
        self.coordinate = CLLocationCoordinate2D(latitude: latitude!, longitude: longitude!)
    }
    
}

