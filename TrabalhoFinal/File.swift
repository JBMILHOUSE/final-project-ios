//
//  File.swift
//  TrabalhoFinal
//
//  Created by user182008 on 27/11/20.
//

import Foundation
import UIKit

class file: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var selecionador = UIImagePickerController();
    var viewController : UIViewController?
    
    var retornarSelecionador: ((UIImage)->())?;
    
    var alerta = UIAlertController(title: "Escolha uma opcao", message: nil, preferredStyle: .actionSheet)
    
    func abrirGaleria(){
        alerta.dismiss(animated: true, completion: nil)
        selecionador.sourceType = .photoLibrary
        self.viewController?.present(selecionador, animated: true, completion: nil)
    }
    
    func selecionaImagem(_ viewController: UIViewController, _ retorno : @escaping((UIImage)-> ())) {
        retornarSelecionador = retorno
        self.viewController = viewController
        
        let galeria = UIAlertAction(title: "Galeria", style: .default) {
            UIAlertAction in self.abrirGaleria()
            
        }
        let cancela = UIAlertAction(title: "Cancelar", style: .default, handler: nil)
        
        selecionador.delegate = self
        
        alerta.addAction(galeria)
        alerta.addAction(cancela)
        
        alerta.popoverPresentationController?.sourceView = self.viewController!.view
        viewController.present(alerta, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[.originalImage] as? UIImage else {
            fatalError("Esperar uma imagem \(info)")
        }
        retornarSelecionador?(image)
    }
    
}
