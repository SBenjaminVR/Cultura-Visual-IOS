//
//  DetalleNuevoCuestionario.swift
//  Cultura Visual y Sonora
//
//  Created by user168609 on 4/19/20.
//  Copyright © 2020 ITESM. All rights reserved.
//

import UIKit

class DetalleNuevoCuestionario: UIViewController, protocoloAgregaPreg {
    
    @IBOutlet weak var tfNombreCuest: UITextField!
    @IBOutlet weak var tfTiempoCuest: UITextField!

    var listaPreguntas:[Pregunta] = [Pregunta]()
    var cantPreg : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func creaCuestionario() {
        let nomb = tfNombreCuest.text
        let tiem:Double = (tfTiempoCuest.text! as NSString).doubleValue
        
        let nuevoCuestionario = Cuestionario(nom: nomb!, numPreg: cantPreg, preg: listaPreguntas, tiempo: tiem)
        
        for preg in nuevoCuestionario.preguntas {
            print(preg.descripcion)
        }
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let viewPreguntas = segue.destination as! CreacionCuestionario
        viewPreguntas.delegado = self
    }
    
    func agregaPreguntas(pregs: [Pregunta]) {
        listaPreguntas = pregs
        creaCuestionario()
    }

}
