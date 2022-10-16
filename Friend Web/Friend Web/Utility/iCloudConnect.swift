//
//  iCloudConnect.swift
//  Friend Web
//
//  Created by Luis Bravo on 10/15/22.
//

import Foundation
import CloudKit
import Combine
import UIKit

// MARK: iCloud View Model

let container = CKContainer(identifier: "iCloud.HugoBravo.Friend-Web")

class CloudKitUserViewModel : ObservableObject {
    @Published var permissionStatus : Bool = false
    @Published var isSignedInToiCloud : Bool = false
    @Published var error : String = ""
    @Published var userName : String = ""
    @Published var userList = [UserModel]()
    init() {
        getiCloudStatus()
        requestPermission()
        fetchiCloudUserRecordID()
    }
    
    private func getiCloudStatus(){
        
            container.accountStatus { [weak self] returnedStatus, returnedError in
                    switch returnedStatus {
                    case .available:
                        self?.isSignedInToiCloud = true
                    case .noAccount:
                        self?.error = CloudKitError.iCloudAccountNotFound.rawValue
                    case .couldNotDetermine:
                        self?.error = CloudKitError.iCloudAccountNotDetermined.rawValue
                    case .restricted:
                        self?.error = CloudKitError.iCloudAccountRestricted.rawValue
                    default:
                        self?.error = CloudKitError.iCloudAccountUnknown.rawValue
                    }
            }
    }
    
    func requestPermission(){
        container.requestApplicationPermission([.userDiscoverability]) { [weak self] returnedStatus, returnedError in

                if returnedStatus == .granted{
                    self?.permissionStatus = true
                    
                }

        }
    }
    
    func fetchiCloudUserRecordID(){
        container.fetchUserRecordID { returnedID, returnedError in
            if let id = returnedID {
                self.discoveriCloudUser(id: id)
            }
        }
    }
    
    func discoveriCloudUser(id : CKRecord.ID) {
        container.discoverUserIdentity(withUserRecordID: id) { returnedIdentity, returnedError in
            DispatchQueue.main.async {
                if let name = returnedIdentity?.nameComponents?.givenName {
                    self.userName = name
                }
            }
        }
    }
    
    enum CloudKitError : String, LocalizedError {
        case iCloudAccountNotFound
        case iCloudAccountNotDetermined
        case iCloudAccountRestricted
        case iCloudAccountUnknown
    }
    
    
    func fetchItems(){
        
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: "User", predicate: predicate)
        let queryOperation = CKQueryOperation(query: query)
        var returnedUsers = [UserModel]()
        
        if #available(iOS 15.0, *) {
            queryOperation.recordMatchedBlock = {(returnedRecordID, returnedResult) in
                switch returnedResult {
                case .success(let record):
                    guard let username = record["username"] as? String else {return}
                    guard let password = record["password"] as? String else {return}
                    guard let age = record["age"] as? Int else {return}
                    guard let sex = record["sex"] as? String else {return}
                    guard let firstName = record["firstName"] as? String else {return}
                    guard let lastName = record["lastName"] as? String else {return}
                    guard let description = record["description"] as? String else {return}
                    guard let friendsList = record["friendList"] as? [String] else {return}

                    returnedUsers.append(UserModel(username: username, password: password, age: age, sex: sex, firstName: firstName, lastName: lastName, description: description, friendsList: friendsList))
                    
                    
                case .failure(let error):
                    print("error recordMatchedBlock \(error)")
                }
            }
        } else {
            
            queryOperation.recordFetchedBlock = {returnedRecord in
                guard let username = returnedRecord["username"] as? String else {return}
                guard let password = returnedRecord["password"] as? String else {return}
                guard let age = returnedRecord["age"] as? Int else {return}
                guard let sex = returnedRecord["sex"] as? String else {return}
                guard let firstName = returnedRecord["firstName"] as? String else {return}
                guard let lastName = returnedRecord["lastName"] as? String else {return}
                guard let description = returnedRecord["description"] as? String else {return}
                guard let friendsList = returnedRecord["friendList"] as? [String] else {return}
                
                self.userList.append(UserModel(username: username, password: password, age: age, sex: sex, firstName: firstName, lastName: lastName, description: description, friendsList: friendsList))
            }
        }
        
        if #available(iOS 15.0, *){
            queryOperation.queryResultBlock = {[weak self] returnedResult in
                print("Returned queryResultBlock: \(returnedResult)")
                    self?.userList = returnedUsers
            }
        }
        else{
            queryOperation.queryCompletionBlock = {[weak self] (returnedCuror, returnedError) in
                print("Returned queryCompletionBlock")
                self?.userList = returnedUsers
                
            }
        }
        
        addOperation(operation: queryOperation)
    }
    
    func addOperation(operation : CKDatabaseOperation){
        container.publicCloudDatabase.add(operation)
    }
    
}


// MARK: UserModel

struct UserModel : Equatable, Codable, Identifiable {
    var id = UUID()
    let username : String
    let password : String
    let age : Int
    let sex : String
    let firstName : String
    let lastName : String
    let description : String
    let friendsList : [String]
    
    static func == (lhs: UserModel, rhs: UserModel) -> Bool {
        lhs.username == rhs.username
    }

    
}



