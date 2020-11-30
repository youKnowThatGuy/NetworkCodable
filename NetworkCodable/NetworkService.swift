//
//  NetworkService.swift
//  NetworkCodable
//
//  Created by Клим on 30.11.2020.
//

import Foundation

class NetworkService{
    static func loadData(completion: @escaping ([Station], Error?) -> Void ){
        guard let url = URL(string: "https://swapi.dev/api/people/") else{
            let error = NSError(domain: "URLResponseError", code: 88005553535, userInfo: nil)
            completion([], error)
            return
        }
        
        
        
        
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 15
        let session = URLSession(configuration: config)
        
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error{
                print(error)
                
                DispatchQueue.main.async{
                    completion([], error)
                }
                return
            }
            
            let response = response as! HTTPURLResponse
            guard let data = data
            else{
                //error handling
                let error = NSError(domain: "Data error occured, status code: \(response.statusCode)", code: response.statusCode, userInfo: nil)
                
                DispatchQueue.main.async{
                completion([], error)
                }
                
                return
            }
            
            do {
                let results =  try JSONDecoder().decode(Info.self, from: data)
                let mas = results.stations
                
                DispatchQueue.main.async {
                    completion(mas, nil)
                }
            }
            
            catch (let jsonError) {
                print(jsonError)
                
                DispatchQueue.main.async {
                    completion([], jsonError)
                }
                return
            }
        }
        task.resume()
    }
    
    }
