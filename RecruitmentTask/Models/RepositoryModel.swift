//
//  Repository.swift
//  RecruitmentTask
//
//  Created by Lefdili Alaoui Ayoub on 5/4/2022.
//

import Foundation
import UIKit


// MARK: - Init
struct GithubResult: Decodable {
    let totalCount: Int
    let items: [Repositories]

    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case items
    }
}

// MARK: - Item
struct Repositories: Decodable {
    let name: String
    let owner: Owner
    let htmlUrl: String
    let stars: Int
    
    enum CodingKeys: String, CodingKey {
        case stars = "stargazers_count"
        case htmlUrl = "html_url"
        case name, owner
    }
}

// MARK: - Owner
struct Owner: Decodable {
    let id: Int
    let login: String
    let avatarURL: String

    enum CodingKeys: String, CodingKey {
        case id, login
        case avatarURL = "avatar_url"
    }
}

struct Repository: Decodable {
    
    var id: Int
    var title: String
    var avatarURL: String?
    var stars: Int
    var author: String?

    enum CodingKeys: String, CodingKey {
        case id
        case title = "name"
        case stars = "stargazers_count"
        case authorName = "login"
        case avatarUrl = "avatar_url"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decode(Int.self, forKey: .id)
        self.title = try container.decode(String.self, forKey: .title)

        let OwnerList = try container.decode(Owner.self, forKey: .authorName)
        self.author = OwnerList.login
        
        let avatarUrl = OwnerList.avatarURL
        self.avatarURL = avatarUrl

        self.stars = try container.decode(Int.self, forKey: .stars)
        
    }
    
}



