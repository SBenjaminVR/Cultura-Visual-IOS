//
//  Intento.swift
//  Cultura Visual y Sonora
//
//  Created by user168609 on 4/14/20.
//  Copyright © 2020 ITESM. All rights reserved.
//

import UIKit

class Intento: NSObject {
    var correctas : Int
    var incorrectas : Int
    var usuario : String
    var cuestionario : String
    var respuestasUsuario : [Int]
    
    init(corr:Int, incorr:Int, user:String, cuest:String, respUser: [Int]) {
        self.correctas = corr
        self.incorrectas = incorr
        self.usuario = user
        self.cuestionario = cuest
        self.respuestasUsuario = respUser
    }
}
