//
//  CommitsModel.swift
//  RecruitmentTask
//
//  Created by Lefdili Alaoui Ayoub on 5/4/2022.
//

import Foundation


// MARK: - Commits History
struct CommitsHistory: Codable {
    let sha, nodeID: String
    let commit: Commit

    enum CodingKeys: String, CodingKey {
        case sha
        case nodeID = "node_id"
        case commit
    }
}

// MARK: - Commit
struct Commit: Codable {
    let author: Author
    let message: String
    
    enum CodingKeys: String, CodingKey {
        case message
        case author
    }
}

// MARK: - Author
struct Author: Codable {
    let name, email: String
}

struct Commits: Decodable {
    
    var message: String
    var authorName: String
    
    enum CodingKeys: String, CodingKey {
        case message
        case authorName = "name"
    }
}
