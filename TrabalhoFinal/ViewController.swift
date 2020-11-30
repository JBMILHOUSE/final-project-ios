//
//  ViewController.swift
//  TrabalhoFinal
//
//  Created by user182008 on 26/11/20.
//

import UIKit

var vSpinner: UIView?

class ViewController: UIViewController {
    var resposta = respostaRest()

    @IBOutlet weak var ivImage: UIImageView!
    
    @IBOutlet weak var btnUpload: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func selecionador(_ sender: Any) {
        file().selecionadorImagem(self) {
            ivImage in self.ivImage.image = ivImage
        }
    }
    @IBAction func fazerUpload(_ sender: Any) {
        
        self.showSpinner(onView: self.view)
        Rest.loadData("17289", "IOs Latoya", self.ivImage.image!, onComplete: {( respostaRest ) in
            let resp = respostaRest
            print(resp.id)
            DispatchQueue.main.async {
                print("inserido")
            }
            self.removeSpinner()
        }, onError: {( dadoErro ) in self.removeSpinner()
            print(dadoErro)
        })
    }
}

extension UIViewController {
    
    func showSpinner(onView : UIView){
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5,alpha: 0.5)
        let ai = UIActivityIndicatorView.init(style: .whiteLarge)
        ai.startAnimating()
        ai.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
        }
        vSpinner = spinnerView
    }
    
    func removeSpinner(){
        DispatchQueue.main.async {
            vSpinner?.removeFromSuperview()
            vSpinner = nil
        }
    }
}


