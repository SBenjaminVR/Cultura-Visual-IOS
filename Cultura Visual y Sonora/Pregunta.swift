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
    var respuestas : [String] = []
    var respuestaCorrecta : Int = 0
    var tipoRespuestas : String = ""
    var imagenes : [UIImage] = []
    var categoria : String = ""
    var imgPregunta : UIImage!
    
    init(desc:String, resp:[String], correcta:Int, tipo:String, imgs:[UIImage], categ:String, imgPreg:UIImage!) {
        self.descripcion = desc
        self.respuestas = resp
        self.respuestaCorrecta = correcta
        self.tipoRespuestas = tipo
        self.imagenes = imgs
        self.categoria = categ
        self.imgPregunta = imgPreg
    }
    
}
