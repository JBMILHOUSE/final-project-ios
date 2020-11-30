//
//  segundaViewController.swift
//  TrabalhoFinal
//
//  Created by user182008 on 26/11/20.
//

import UIKit

class segundaViewController: UIViewController {
    var resposta = respostaRest();

    @IBOutlet weak var ivFoto: UIImageView!
    @IBOutlet weak var btnUpload: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func tirarFoto(_ sender: Any) {
        
        file().selecionadorImagemSelfie(self) {imagem in print("Foto tirada")
            self.ivFoto.image = imagem
        }
    }
    
    @IBAction func fazerUpload(_ sender: Any) {
        
        self.showSpinner(onView: self.view)
        Rest.loadData("17289", "IOs Chris", self.ivFoto.image!,
                      onComplete: {(respostaRest) in
                    let resp = respostaRest
                     print(resp.id)
                    DispatchQueue.main.async {
                      print("id inserido")
                    }
                    self.removeSpinner()
        
    }, onError: { (dadoErro) in
        self.removeSpinner()
        print(dadoErro)
     })
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
