//
//  Rest.swift
//  TrabalhoFinal
//
//  Created by user182008 on 27/11/20.
//

import Foundation
import UIKit

extension UIImage {
    func toBase64() -> String? {
        guard let imageData = self.pngData() else { return nil }
        return imageData.base64EncodedString(options: Data.Base64EncodingOptions.lineLength64Characters)
    }
}

enum dadoErro{
    case urlErro
    case taskEror(error: Error)
    case noResponse
    case noData
    case responseStatusCode(code: Int)
    case invalidJSON
}

class respostaRest: Codable{
      var success: Bool
      var response: String
      var responseDescription: String
      var id: String
      
      init() {
          self.success = false
          self.response = ""
          self.responseDescription = ""
          self.id = "-1"
      }
}

class Rest {
    
    private static let basePath = "https://www.slmm.com.br/DS403/index.php"
    
    private static let configuration: URLSessionConfiguration = {
        let config = URLSessionConfiguration.default
        config.allowsCellularAccess = false
        config.httpAdditionalHeaders = ["Content-type": "application/json"]
        config.timeoutIntervalForRequest = 30.0
        config.httpMaximumConnectionsPerHost = 5
        return config
    }()

    private static let session = URLSession(configuration: configuration)


    class func loadData(_ ra: String,_ descricao: String,_ img: UIImage, onComplete: @escaping(respostaRest) -> Void, onError: @escaping(dadoErro)-> Void){
        
        //var dados : [DadosFoto] = []
        
        let url1 = basePath.appending(ra)
                    print(url1)
    
        guard let url = URL(string: url1) else {
            print("erro /{url1}")
            onError(.urlErro)
            return
        }
        
        // por problemas no servidor a foto tem que ser menor que 10Mb
        let imgScale = img.jpegData(compressionQuality: 0.7)
        // let foto = foto1.toBase64()
        // cria um optional e ai tem que desempacotar formato png
        let foto = imgScale?.base64EncodedString()
        var json = [String:Any]()
        json["ra"] = ra
        json["descricao"] = descricao
        json["foto"] = foto!   // tira o option da sring
    
        do {
                   
                   let data = try JSONSerialization.data(withJSONObject: json, options: [])
                   var request = URLRequest(url: url)
                   request.httpMethod = "POST"
                   request.httpBody = data
                   request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                   request.addValue("application/json", forHTTPHeaderField: "Accept")
               
                   let dataTask = URLSession.shared.dataTask(with: request, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) in
                
                       if error == nil {  // sem erro na task
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
                                   let dadosR = try JSONDecoder().decode( respostaRest.self , from: data)
                                   print(dadosR.response)
                                   print(dadosR.id)
                                   
                                   onComplete(dadosR)
                                   
                               }catch {
                                   print(error)
                                   onError(.invalidJSON)
                               }
                               
                           }else{
                               onError(.responseStatusCode(code: response.statusCode))
                               print("deu erro")
                           }
                           
                       } else{
                           onError(.taskEror(error: error!))
                           print(error!)
                       }
                       
                   })
                       
               dataTask.resume()
               }
               catch {
                   print("erro ao enviar")
               }
               
           }
  }
