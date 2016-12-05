//
//  MarketDatabase.swift
//  GroupProject
//
//  Created by Alexander Mason on 11/17/16.
//  Copyright © 2016 Alexander Mason. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth

//MARK: - Authorization functions
class FirebaseAPI {
    static func signUp(email: String, password: String, name: String, completion: @escaping (Bool) -> () ) {
        let ref = FIRDatabase.database().reference().root
        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error) in
            if error == nil {
                ref.child("users").child((user?.uid)!).child("email").setValue(email)
                ref.child("users").child((user?.uid)!).child("name").setValue(name)
                completion(true)
            } else {
                print(error!)
                completion(false)
            }
        })
    }
    
    static func signIn(email: String, password: String, completion: @escaping (Bool) -> () ) {
        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
            if error == nil {
                completion(true)
            } else {
                completion(false)
            }
        })
    }
    
    static func userIsLoggedIn() -> Bool {
        
        return FIRAuth.auth()?.currentUser != nil ? true : false
        
    }
}




//MARK: - Market structure functions
extension FirebaseAPI {
    
    static func pullMarketsFromFirebase(completion: @escaping ([String : [String : String]]) -> () ) {
        let ref = FIRDatabase.database().reference().child("markets")
        
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as! [String : [String : String]]
            completion(value)
        })
    }
}

//MARK: - Comment structure functions
extension FirebaseAPI {
    
    static func writeCommentFor(market: String, with message: String, from name: String) {
        let uid = FIRAuth.auth()?.currentUser?.uid
        let ref = FIRDatabase.database().reference().child("comments")
        let marketRef = ref.child("\(market)").childByAutoId()
        marketRef.child("timeStamp").setValue(Date().timeIntervalSince1970)
        marketRef.child("comment").setValue(message)
        marketRef.child("likes").setValue(0)
        marketRef.child("id").setValue(uid)
        marketRef.child("name").setValue(name)
    }
    
    static func readCommentFor(market: String, completion: @escaping ([String : [String : Any]]) -> () ) {
        
        let ref = FIRDatabase.database().reference().child("comments").child("\(market)")
        ref.observeSingleEvent(of: .value, with: { snapshot in
            guard snapshot.exists() else {
                print("Comments don't exist")
                return
            }
            let value = snapshot.value as! [String : [String : Any]]
            completion(value)
        })
    }
    
    static func writeToLikes(with ref: FIRDatabaseReference, newLikes: Int) {
        ref.setValue(newLikes)
    }
    
    static func increaseLikesWith(commentID: String, in market: String) {
        let ref = FIRDatabase.database().reference().child("comments").child("\(market)").child("\(commentID)").child("likes")
        ref.observeSingleEvent(of: .value, with: {snapshot in
            
            let likes = snapshot.value as! Int
            writeToLikes(with: ref, newLikes: likes + 1)
            
        })
    }
    
    static func writeReportFor(commentID: String) {
        let ref = FIRDatabase.database().reference().child("reports").child(commentID)
        
//        ref.runTransactionBlock({ (currentData) -> FIRTransactionResult in
//            if var post = currentData.value as? [String : AnyObject], let uid = FIRAuth.auth()?.currentUser?.uid {
//                var stars: Dictionary<String, Bool>
//                stars = post["stars"] as? [String : Bool] ?? [:]
//                var starCount = post["starCount"] as? Int ?? 0
//                if let _ = stars[uid] {
//                    // Unstar the post and remove self from stars
//                    starCount -= 1
//                    stars.removeValue(forKey: uid)
//                } else {
//                    // Star the post and add self to stars
//                    starCount += 1
//                    stars[uid] = true
//                }
//                post["starCount"] = starCount as AnyObject?
//                post["stars"] = stars as AnyObject?
//                
//                // Set value and report transaction success
//                currentData.value = post
//                
//                return FIRTransactionResult.success(withValue: currentData)
//            }
//        }, andCompletionBlock: { (error, committed, snapshot) in
//            if let error = error {
//                print(error.localizedDescription)
//            }
//        })
        
    }
    
}

//MARK: - UpdateMarkets structure functions
extension FirebaseAPI {
    
    static func writeToUpdate(with marketName: String, changes: [String : String]) {
        
        if changes.isEmpty { return }
        
        let ref = FIRDatabase.database().reference().child("updateMarkets")
        
        ref.child("\(marketName)").childByAutoId().setValue(changes)
        
    }
    
    static func readFromUpdate(with marketName: String, completion: @escaping ((Bool, [String : Any])) -> () ) {
        
        let ref = FIRDatabase.database().reference().child("updateMarkets").child("\(marketName)")
        
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            
            if snapshot.exists() {
                let results = snapshot.value as! [String : Any]
                completion((true, results))
            } else {
                completion((false,[:]))
            }
        })
    }
    
    static func upvoteInMarket(for marketName: String, with marketID: String, upvoted: Bool) {
        //make sure people cant upvote same thing over and over and over 
        let ref = FIRDatabase.database().reference().child("updateMarkets").child("\(marketName)").child("\(marketID)")
        
        ref.runTransactionBlock({ (currentData) -> FIRTransactionResult in
            var post = currentData.value as! [String : String]
            var votes = post["votes"]!
            if upvoted {
                votes = String(Int(votes)! + 1)
            } else {
                votes = String(Int(votes)! - 1)
            }
            
            post["votes"] = votes
            currentData.value = post
            
            return FIRTransactionResult.success(withValue: currentData)
        }, andCompletionBlock: { (error, committed, snapshot) in
            if let error = error {
                print(error)
            } else {
                //if votes is over a certain amount, use function to replace appropriate fields and remove appropriate database objects
            }
        })
        
    }
    
}



//MARK: - Load Firebase with information from CSV file
extension FirebaseAPI {
    static func makeMarkets() {
        let ref = FIRDatabase.database().reference()
        
        let marketsRef = ref.child("markets")
        
        let returnDictionary = Parser.csvParser()
        
        var count = 0
        for dictionary in returnDictionary {
            count += 1
            
            let nameChild = marketsRef.child(dictionary["name"]!)
            
            let addressRef = nameChild.child("address")
            addressRef.setValue(dictionary["address"])
            
            let latitudeRef = nameChild.child("latitude")
            latitudeRef.setValue(dictionary["latitude"])
            
            let longitudeRef = nameChild.child("longitude")
            longitudeRef.setValue(dictionary["longitude"])
            
            let timeOfYearValue = dictionary["timeOfYear"]
            let timeOfYearTuple = Parser.timeOfYear(monthString: timeOfYearValue!)
            
            let openDate = nameChild.child("openDate")
            openDate.setValue(timeOfYearTuple.0)
            
            let closeDate = nameChild.child("closeDate")
            closeDate.setValue(timeOfYearTuple.1)
            
            let timeOfDayValue = dictionary["timeOfDay"]
            let dayTuple = Parser.timeOfDay(dayString: timeOfDayValue!)
            
            let startTime = nameChild.child("startTime")
            startTime.setValue(dayTuple.0)
            
            let endTime = nameChild.child("endTime")
            endTime.setValue(dayTuple.1)
            
            let datesRef = nameChild.child("days")
            datesRef.setValue(dictionary["days"])
            
            let ebtRef = nameChild.child("ebt")
            ebtRef.setValue(dictionary["EBT"])
            
            let boroughRef = nameChild.child("borough")
            boroughRef.setValue(dictionary["borough"])
            
            let websiteRef = nameChild.child("website")
            websiteRef.setValue(dictionary["website"])
            
            let extrasRef = nameChild.child("extras")
            extrasRef.setValue(dictionary["extras"])
            
        }
    }
}

//MARK: Add market to firebase database

extension FirebaseAPI {
    static func addMarketToFirebase(name: String, address: String, lat: String, long: String, openDate: String, closeDate: String, openTime: String, closeTime: String, acceptEBT: String, days: String) {
        
        
        let ref = FIRDatabase.database().reference().child("addMarket")
        
        let nameChild = ref.child(name)
        
        
        let returnDict = ["address": address, "latitude": lat, "longitude": long, "openDate": openDate, "closeDate": closeDate, "startTime": openTime, "endTime": closeTime, "ebt": acceptEBT, "days": days]
        
        nameChild.setValue(returnDict)
        
    }
    
}












