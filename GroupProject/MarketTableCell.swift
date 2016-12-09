//
//  MarketCellTableViewCell.swift
//  mapKitTest
//
//  Created by Neill Perry on 11/22/16.
//  Copyright © 2016 PuddingSmile. All rights reserved.
//

import UIKit

class MarketTableCell: UITableViewCell {
    
    var marketView: MarketView!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: "marketCell")
        
        marketView = MarketView(frame: self.bounds)
        self.addSubview(marketView)
        constrainThisView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        
    }
    
    func constrainThisView() {
        
        marketView.translatesAutoresizingMaskIntoConstraints = false
        marketView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        marketView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        marketView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        marketView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        marketView = MarketView(frame: self.bounds)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
