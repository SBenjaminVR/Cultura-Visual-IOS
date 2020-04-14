//
//  Pregunta.swift
//  Cultura Visual y Sonora
//
//  Created by user168609 on 4/14/20.
//  Copyright © 2020 ITESM. All rights reserved.
//

import UIKit

class Pregunta: NSObject {
    var descripcion : String = ""
    var respuestas : [Int] = []
    var respuestaCorrecta : Int = 0
    var tipoRespuestas : String = ""
    var imagenes : [UIImage] = []
    var categoria : String = ""
    
    init(desc:String, resp:[Int], correcta:Int, tipo:String, imgs:[UIImage], categ:String) {
        self.descripcion = desc
        self.respuestas = resp
        self.respuestaCorrecta = correcta
        self.tipoRespuestas = tipo
        self.imagenes = imgs
        self.categoria = categ
    }
    
}
