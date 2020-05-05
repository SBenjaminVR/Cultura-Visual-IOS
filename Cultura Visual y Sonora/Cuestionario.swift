//
//  Cuestionario.swift
//  Cultura Visual y Sonora
//
//  Created by user168609 on 4/14/20.
//  Copyright © 2020 ITESM. All rights reserved.
//

import UIKit

class Cuestionario: NSObject {
    var nombre : String = ""
    var numeroDePreguntas : Int = 0
    var preguntas : [Pregunta] = []
    var tiempoCuestionario : Double = 0.0
    
    init(nom:String, numPreg:Int, tiempo:Double) {
        self.nombre = nom
        self.numeroDePreguntas = numPreg
        self.tiempoCuestionario = tiempo
    }
    
    func addQuestions(preguntas: [Pregunta]) {
        self.preguntas = preguntas
    }
}
