//
//  Usuario.swift
//  Cultura Visual y Sonora
//
//  Created by user168609 on 4/14/20.
//  Copyright © 2020 ITESM. All rights reserved.
//

import UIKit

class Usuario: NSObject {
    var nombre : String = ""
    var tipoUsuario : String = ""
    var username : String = ""
    var password : String = ""
    
    init(nom:String, tipo:String, user:String, passw:String) {
        self.nombre = nom
        self.tipoUsuario = tipo
        self.username = user
        self.password = passw
    }
}
