//
//  RequestChangeView.swift
//  GroupProject
//
//  Created by Benjamin Su on 11/28/16.
//  Copyright © 2016 Alexander Mason. All rights reserved.
//

import Foundation
import UIKit

protocol CommentsViewDelegate: class {
    func triggerBackSegue()
    func triggerCommentsSegue()
    func prepare(for segue: UIStoryboardSegue, sender: Any?)
}

class CommentsView: UIView, UITableViewDelegate, UITableViewDataSource {
    
    weak var delegate: CommentsViewDelegate!
    
    var market: Market!
    var tableView: UITableView!
    var comments = [MarketComment]()
    
    //MARK: - Navigation Objects
    var navigationView : UIView!
    var backButton:  UIButton!
    var commentButton: UIButton!

    override init(frame: CGRect){
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func commonInit() {
        createLayout()
        loadConstraints()
    }
    
    
    
    //MARK: - Logic functions
    func readForComments() {
        self.comments.removeAll()

        FirebaseAPI.readCommentFor(market: self.market.name!, completion: { commentId in
            
            FirebaseAPI.getUserReportedList(handler: { (reportData) in
                
                for (key, value) in commentId {
                    
                    if let _ = reportData?[key] {
                    
                    } else {
        
                        //Add to local array of comments
                        self.comments.append(MarketComment(id: key, value: value))
                    }
                }
            
                //Reload table view data
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            })
        })
    }


    func backButtonAction() {
       delegate?.triggerBackSegue()
    }
    
    func commentButtonAction() {
        delegate?.triggerCommentsSegue()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if comments.count > 0 {
            return comments.count
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //MARK: - Segues
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "commentCell", for: indexPath) as! CommentTableViewCell
        let comment: MarketComment!
        if comments.count > 0 {
            comment = comments[indexPath.row]
        } else {
            comment = MarketComment(id: "13423423", value: ["comment": "There are no comments for \(self.market.name!)"])
        }
        cell.market = market
        cell.commentObject = comment
        cell.addConstraints()
        cell.updateConstraintsIfNeeded()
        return cell
    }
    
   
}


//MARK: - create subviews
extension CommentsView {
    func createLayout() {
        //Add TableView
        tableView = UITableView()
        
        self.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = false
        tableView.backgroundColor = UIColor.themeTertiary
        tableView.register(CommentTableViewCell.self, forCellReuseIdentifier: "commentCell")
        
        //Add Navigation Bar
        navigationView = UIView()
        self.addSubview(navigationView)
        navigationView.backgroundColor = UIColor.themeTertiary
        
        //Add Back Button
        backButton = UIButton()
        navigationView.addSubview(backButton)
        backButton.setImage(UIImage(named: "backIconPng"), for: .normal)
        backButton.addTarget(self, action: #selector(backButtonAction), for: .touchUpInside)
        
        //Add Comment Button
        commentButton = UIButton()
        navigationView.addSubview(commentButton)
        commentButton.setTitle("Add a Comment", for: .normal)
        commentButton.addTarget(self, action: #selector(commentButtonAction), for: .touchUpInside)
        commentButton.titleEdgeInsets.left = 5
        commentButton.titleEdgeInsets.right = 5
    }
    
}


//MARK: - Constraints
extension CommentsView {
    func loadConstraints() {
        
        //TableView Constraints
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: self.topAnchor, constant: self.bounds.height * 0.07).isActive = true
        tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        tableView.widthAnchor.constraint(equalToConstant: self.bounds.width).isActive = true
        tableView.heightAnchor.constraint(equalToConstant: self.bounds.height * 0.93).isActive = true
        tableView.separatorStyle = .none
        
        
        //Navigation Bar Constraints
        navigationView.translatesAutoresizingMaskIntoConstraints = false
        navigationView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        navigationView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        navigationView.widthAnchor.constraint(equalToConstant: self.bounds.width).isActive = true
        navigationView.heightAnchor.constraint(equalToConstant: self.bounds.height * 0.07).isActive = true
        
        //Back Button Constraints
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.topAnchor.constraint(equalTo: navigationView.topAnchor, constant: self.bounds.height * 0.03).isActive = true
        backButton.leadingAnchor.constraint(equalTo: navigationView.leadingAnchor, constant: self.bounds.width * 0.03).isActive = true
        backButton.widthAnchor.constraint(equalToConstant: self.bounds.height * 0.035).isActive = true
        backButton.heightAnchor.constraint(equalToConstant: self.bounds.height * 0.035).isActive = true
        
        //Comment Button Constraints
        commentButton.translatesAutoresizingMaskIntoConstraints = false
        commentButton.topAnchor.constraint(equalTo: navigationView.topAnchor, constant: self.bounds.height * 0.03).isActive = true
        commentButton.leadingAnchor.constraint(equalTo: navigationView.leadingAnchor, constant: self.bounds.width * 0.55).isActive = true
        commentButton.widthAnchor.constraint(equalToConstant: self.bounds.width * 0.4).isActive = true
        commentButton.heightAnchor.constraint(equalToConstant: self.bounds.width * 0.07).isActive = true
        commentButton.backgroundColor = UIColor.themePrimary
        commentButton.titleLabel?.textColor = UIColor.black
        commentButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: 10)
        commentButton.layer.borderWidth = CGFloat(2)
        
        commentButton.layer.cornerRadius = CGFloat(7)
        commentButton.layer.borderColor = UIColor.themeAccent2.cgColor
    }
}


















