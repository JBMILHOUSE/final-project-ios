//
//  apiPost.swift
//  TrabalhoFinal
//
//  Created by user182008 on 30/11/20.
//

import Foundation

class ApiPost {
    
    private static let basePath = "https://www.slmm.com.br/DS403?ra="
    
    private static let configuration: URLSessionConfiguration = {
        let config = URLSessionConfiguration.default
        config.allowsCellularAccess = false
        config.httpAdditionalHeaders = ["Content-type": "application/json"]
        config.timeoutIntervalForRequest = 30.0
        config.httpMaximumConnectionsPerHost = 5
        return config
    }()
    
    private static let session = URLSession(configuration: configuration)
    
    class func loadData(_ ra: String, onComplete: @escaping([DadosFoto])-> Void, onError: @escaping(erroStatus)-> Void){
        
        let url1 = basePath.appending(ra)
        print(url1)
        
        guard let url = URL(string: url1) else {
            print("erro/{url1}")
            onError(.urlErro)
            return
        }
        
        let dataTask = session.dataTask(with: url, completionHandler: {
            (data: Data?, response: URLResponse?, error: Error?) in
              if error == nil {
                guard let response = response as? HTTPURLResponse else {
                    print("erro de resposta")
                    onError(.noResponse)
                    return
                 }
                 if response.statusCode == 200 {
                    guard let data = data else {
                        print("erro de dados")
                        return
                 }
                 print(data)
                 do {
                    let dados = try JSONDecoder().decode([DadosFoto].self, from: data)
                    print(dados[0].descricao)
                    print(dados[0].id)
                    
                    onComplete(dados)
                 } catch {
                    print(error)
                    onError(.invalidJson)
                 }
                    
                 } else {
                    onError(.responseStatusCode(code: response.statusCode))
                 }
                
              } else {
                onError(.taskErro(error: error!))
                print(error!)
              }
        })
        dataTask.resume()
    }
}
