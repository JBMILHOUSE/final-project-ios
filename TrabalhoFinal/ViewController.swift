//
//  ViewController.swift
//  TrabalhoFinal
//
//  Created by user182008 on 26/11/20.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var ivImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func selecionador(_ sender: Any) {
        file().selecionaImagem(self) {
            ivImage in self.ivImage.image = ivImage
        }
    }
}

