//
//  APIManager.swift
//  RecruitmentTask
//
//  Created by Lefdili Alaoui Ayoub on 5/4/2022.
//

import UIKit

enum NetworkError: Error {
    case badUrl
    case badResponse
    case invalidDecode
    
    var localizedDescription: String {
        switch self {
        case .badUrl:
            return "Invalid URL"
        case .badResponse:
            return "Corrupted Response"
        case .invalidDecode:
            return "JSON decode failed"
        }
    }
}

class APIManager {
    
    init(){}
    static let shared = APIManager()
    
    let cache = NSCache<NSString, UIImage>()

    /*
     https://api.github.com/search/repositories?q=axabot
     https://api.github.com/search/repositories?q=javascript&per_page=100&page=2
     */
    private let repositoriesBaseUrl = "https://api.github.com/search/repositories"
    private let commitsBaseUrl = "https://api.github.com/repos/"

    func fetchRepositories(keyword: String?, page: Int = 1, completion: @escaping(Result<[Repositories], NetworkError>) -> Void){
        guard let keyword = keyword else {
            return completion(.success([]))
        }
        
        let repositoriesEndPoint = repositoriesBaseUrl + "?q=\(keyword.lowercased())&per_page=100&page=\(page)"
        guard let url = URL(string: repositoriesEndPoint) else {
            return completion(.failure(NetworkError.badUrl))
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else {
                return completion(.failure(NetworkError.badResponse))
            }
            
            do {
                let decoder = JSONDecoder()
                let decodedRepositories = try decoder.decode(GithubResult.self, from: data)
                return completion(.success(decodedRepositories.items))
            }catch{
                return completion(.failure(NetworkError.invalidDecode))
            }
        }
        task.resume()
    }
    
    
    func fetchCommits(repository: Repositories?, completion: @escaping(Result<[CommitsHistory], NetworkError>) -> Void){
        
        guard let repository = repository else {
            return completion(.success([]))
        }
        
        let repoTitle = repository.name
        let repoAuthor = repository.owner.login
        
        let commitsEndPoint = commitsBaseUrl + "\(repoAuthor.lowercased())/\(repoTitle.lowercased())/commits"

        guard let url = URL(string: commitsEndPoint) else {
            return completion(.failure(NetworkError.badUrl))
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else {
                return completion(.failure(NetworkError.badResponse))
            }

            do {
                let decoder = JSONDecoder()
                let decodedCommits = try decoder.decode([CommitsHistory].self, from: data)
                return completion(.success(decodedCommits))
            }catch{
                print(error)
                return completion(.failure(NetworkError.invalidDecode))
            }
        }
        task.resume()
    }
    
}
