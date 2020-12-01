//
//  NetworkService.swift
//  NetworkCodable
//
//  Created by Клим on 30.11.2020.
//

import Foundation

class NetworkService{
    static func loadData(completion: @escaping ([Line], Error?) -> Void ){
        guard let url = URL(string: "https://api.hh.ru/metro/1") else{
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
                let netCode =  try JSONDecoder().decode(Info.self, from: data)
                let metroLine = netCode.lines
                
                DispatchQueue.main.async {
                    completion(metroLine, nil)
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
