//
//  URLSession+Extension.swift
//  SpaceX
//
//  Created by Kairat Yelubay on 21.07.2022.
//

import Foundation

extension URLSession {
    enum CustomError: Error {
        case invalidURL
        case invalidData
        case invalidResponse
    }
    
    func request<T: Codable> (
        url: URL?,
        expecting: T.Type,
        completion: @escaping (Result<T, Error>) -> Void)
    {
        guard let url = url else {
            completion(.failure(CustomError.invalidURL))
            return
        }
        
        let task = dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                      completion(.failure(CustomError.invalidResponse))
                      return
            }
            
            guard let data = data else {
                completion(.failure(CustomError.invalidData))
                return
            }
            
            do {
                let result = try JSONDecoder().decode(expecting, from: data)
                completion(.success(result))
            }
            catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
}
