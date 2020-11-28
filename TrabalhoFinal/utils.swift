//
//  utils.swift
//  TrabalhoFinal
//
//  Created by user182008 on 27/11/20.
//

import Foundation

enum erroStatus {
  case urlErro
  case taskErro(error: Error)
  case noResponse
  case noData
  case responseStatusCode(code: Int)
  case invalidJson
}
