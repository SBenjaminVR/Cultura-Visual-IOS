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
    
    init(desc:String, resp:[String], correcta:Int, tipo:String, categ:String) {
        self.descripcion = desc
        self.respuestas = resp
        self.respuestaCorrecta = correcta
        self.tipoRespuestas = tipo
        self.categoria = categ
    }
    
    func setImagenPregunta(imgPreg:UIImage!) {
        self.imgPregunta = imgPreg
    }
    
    func setImagenesRespuestas(imgs:[UIImage]) {
        self.imagenes = imgs
    }
    
}
