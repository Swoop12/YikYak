//
//  YakController.swift
//  YikYak
//
//  Created by DevMountain on 9/27/18.
//  Copyright © 2018 trevorAdcock. All rights reserved.
//

import Foundation
import CloudKit

class YakController{
    
    //Shared Instance
    static let shared = YakController()
    private init() {}
    
    //Source of Truth
    var yaks: [Yak] = []
    
    //CRUD
    func birthYoungYak(text: String, author: String, completion: ((Yak?) -> Void)?){
        let yak = Yak(text: text, author: author)
        self.yaks.append(yak)
        
        
        CKContainer.default().publicCloudDatabase.save(CKRecord(yak)) { (record, error) in
            if let error = error{
                print("👻 \(error.localizedDescription) \(error) in function: \(#function)")
                completion?(nil)
                return
            }
            guard let record = record else {return}
            let yak = Yak(ckRecord: record)
            completion?(yak)
        }
    }
    
    //MARK: - Fetch
    func herdAllYaks(completion: @escaping ([Yak]?) -> Void){
        
        let predicate = NSPredicate(value: true)
        
        let querry = CKQuery(recordType: Constants.YakRecordType, predicate: predicate)
        
        CKContainer.default().publicCloudDatabase.perform(querry, inZoneWith: nil) { (records, error) in
            if let error = error{
                print("\(error.localizedDescription) \(error) in function: \(#function)")
                completion(nil)
                return
            }
            
            guard let records = records else {return}
            
            let yaks = records.compactMap{ Yak(ckRecord: $0)}
            self.yaks = yaks
            completion(yaks)
        }
    }
}
