//
//  DetalleCuestionario.swift
//  Cultura Visual y Sonora
//
//  Created by user168609 on 4/14/20.
//  Copyright © 2020 ITESM. All rights reserved.
//

import UIKit

class DetalleCuestionario: UIViewController, protocoloRespuestasUsuario {
    
    var cuestionarioSeleccionado : Cuestionario!
    var NumeroDeRespuestas:Int!
    var respuestasUsuario : [Int]!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "\(cuestionarioSeleccionado.nombre)"
        
        setBackground()
        
        NumeroDeRespuestas = cuestionarioSeleccionado.numeroDePreguntas
        
        if respuestasUsuario == nil {
            respuestasUsuario = Array(repeating: 0, count: NumeroDeRespuestas)
        }
    }
        
    func setBackground() -> Void {
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "shinyBackground")
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
    }
    
    func guardaRespuestasUsuario(resps: [Int]) {
        respuestasUsuario = resps
    }
    

    @IBAction func reiniciaRespuestasUsuario(_ sender: UIButton) {
        for i in 0...respuestasUsuario.count-1 {
            respuestasUsuario[i] = 0
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vistaDestino = segue.destination as! RespondeCuestionario
        
        vistaDestino.cuestionarioACargar = cuestionarioSeleccionado
        vistaDestino.respuestasUsuario = respuestasUsuario
        vistaDestino.delegado = self
    }
    
    @IBAction func regresarCuestionarios(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
