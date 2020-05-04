//
//  Intento.swift
//  Cultura Visual y Sonora
//
//  Created by user168609 on 4/14/20.
//  Copyright © 2020 ITESM. All rights reserved.
//

import UIKit

class Intento: NSObject {
    var fecha : Date!
    var calificacion : Double = 0.0
    var tiempo : Double = 0.0
    var aciertos : Int = 0
    var usuario : Usuario
    var cuestionario : Cuestionario
    var respuestasUsuario : [Int]
    
    init(fecha:Date!, cali:Double, tiempo:Double, aciertos:Int, user:Usuario, cuest:Cuestionario, respUser: [Int]) {
        self.fecha = fecha
        self.calificacion = cali
        self.tiempo = tiempo
        self.aciertos = aciertos
        self.usuario = user
        self.cuestionario = cuest
        self.respuestasUsuario = respUser
    }
}
