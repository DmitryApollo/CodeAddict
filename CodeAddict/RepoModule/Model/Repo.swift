//
//  Repo.swift
//  CodeAddict
//
//  Created by Дмитрий on 08/12/2020.
//  Copyright © 2020 Дмитрий. All rights reserved.
//

import Foundation

struct RepoListResponse: Decodable {
    enum CodingKeys: String, CodingKey {
        case items
    }
    let items: [Repo]
}

struct Repo: Decodable {
    var watchers: Int?
    var description: String?
    var name: String?
    var fullName: String?
    var language: String?
    
    var homepage: String?
    var forks: Int?
    var issues: Int?
    var defaultBranch: String?
    var repoUrl: String?
    
    var ownerAvatarUrl: String?
    var ownerName: String?

    enum CodingKeys: String, CodingKey {
        case watchers
        case description
        case name
        case fullName = "full_name"
        case language
        case owner
        
        case homepage
        case issues = "open_issues_count"
        case forks
        case defaultBranch = "default_branch"
        case repoUrl = "html_url"
    }
    
    enum OwnerCodingKeys: String, CodingKey {
        case ownerAvatarUrl = "avatar_url"
        case ownerName = "login"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.watchers = try container.decode(Int?.self, forKey: .watchers)
        self.description = try container.decode(String?.self, forKey: .description)
        self.name = try container.decode(String?.self, forKey: .name)
        self.fullName = try container.decode(String?.self, forKey: .fullName)
        self.language = try container.decode(String?.self, forKey: .language)
        
        self.homepage = try container.decode(String?.self, forKey: .homepage)
        self.issues = try container.decode(Int?.self, forKey: .issues)
        self.forks = try container.decode(Int?.self, forKey: .forks)
        self.defaultBranch = try container.decode(String?.self, forKey: .defaultBranch)
        self.repoUrl = try container.decode(String?.self, forKey: .repoUrl)

        let ownerContainer = try container.nestedContainer(keyedBy: OwnerCodingKeys.self, forKey: .owner)
        self.ownerAvatarUrl = try ownerContainer.decode(String?.self, forKey: .ownerAvatarUrl)
        self.ownerName = try ownerContainer.decode(String?.self, forKey: .ownerName)
    }
}
