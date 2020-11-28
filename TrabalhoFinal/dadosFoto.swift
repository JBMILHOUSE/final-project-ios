//
//  dadosFoto.swift
//  TrabalhoFinal
//
//  Created by user182008 on 27/11/20.
//

import Foundation

class DadosFoto : Codable {
    
    var id: Int
    var descricao: String
    var foto: String
    
    init() {
        self.id = -1
        self.descricao = ""
        self.foto = ""
    }
}
