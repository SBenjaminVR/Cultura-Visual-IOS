//
//  ListaCuestionariosA.swift
//  Cultura Visual y Sonora
//
//  Created by user168609 on 4/14/20.
//  Copyright © 2020 ITESM. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseStorage

class ListaCuestionariosA: UITableViewController {
    
    var listaDatos = ["Arte", "Musica", "Arquitectura"]
    var listaCuestionarios : [Cuestionario] = [Cuestionario]()
    
    var nombre:String = ""
    var tiempo = 0
    var cantPreg = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Cuestionarios"
        obtenerCuestionarios(addCuestionario)
        
        
    }
    
    //MARK: - Save Items From Firebase
    func obtenerCuestionarios(_ completion: @escaping ([QueryDocumentSnapshot])->Void) {
        let cuestRef = Firestore.firestore().collection("Cuestionarios")
          
        cuestRef.getDocuments(completion: { (querySnapshot, error) in
            guard let querySnapshot = querySnapshot else {
                  let alerta = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                  let accion = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                  
                  alerta.addAction(accion)
                  
                  self.present(alerta, animated: true, completion: nil)
                  return
            }
            
            let documents = querySnapshot.documents
            completion(documents)
        })
    }
    
    func addCuestionario(documents: [QueryDocumentSnapshot]) {
        var nombre: String
        var tiempo: Int
        var cantPreg: Int
        var i = 0
        
        for document in documents {
            nombre = document["nombre"] as? String ?? "(noName)"
            tiempo = document["tiempo"] as? Int ?? 0
            cantPreg = document["cantPreguntas"] as? Int ?? 0
            
            self.listaCuestionarios.append(Cuestionario(nom: nombre, numPreg: cantPreg, tiempo: Double(tiempo)))
            
            //let callback = {self.addPreguntas(preguntas: documents, index: i)}
            obtenerPreguntas(addPreguntas, nombre: nombre, i:i)
            
            i+=1
        }
    }
    
    func obtenerPreguntas(_ completion: @escaping ([QueryDocumentSnapshot], String, Int)->Void, nombre: String, i: Int) {
        let pregRef = Firestore.firestore().collection("Cuestionarios").document("\(nombre)").collection("Preguntas")
        
        pregRef.getDocuments(completion: { (querySnapshotP, error) in
            guard let querySnapshotP = querySnapshotP else {
                let alerta = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                let accion = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                
                alerta.addAction(accion)
                
                self.present(alerta, animated: true, completion: nil)
                return
            }
            
            let pregDocs = querySnapshotP.documents
            print(pregDocs)
            completion(pregDocs, nombre, i)
        })
    }

    
    func addPreguntas(preguntas: [QueryDocumentSnapshot], nombre:String, index: Int) {
        var categoria = ""
        var descripcion = ""
        var respCorrecta = 0
        var respuestas = [String]()
        var tipoResp = ""
        var imgPreg:UIImage!
        var imagenes = [UIImage]()
        var j = 0
        var sUrl:String!
        var url:URL!
        var imgRespData:NSData!
        
        for pregDoc in preguntas {
            categoria = pregDoc["categoria"] as? String ?? "noCateg"
            descripcion = pregDoc["descripcion"] as? String ?? "noDesc"
            respCorrecta = pregDoc["respCorrecta"] as? Int ?? 0
            respuestas = pregDoc["respuestas"] as! [String]
            tipoResp = pregDoc["tipoResp"] as? String ?? "noTipoRes"
            
            let nuevaPregunta = Pregunta(desc: descripcion, resp: respuestas, correcta: respCorrecta, tipo: tipoResp, categ: categoria)
            
            sUrl = pregDoc["imagenPreg"] as? String ?? "noImgPregString"
            
            if sUrl != "" {
                url = URL(string: sUrl)
                let imgData = NSData(contentsOf: url!)
                nuevaPregunta.setImagenPregunta(imgPreg: UIImage(data: imgData! as Data))
            } else {
                nuevaPregunta.setImagenPregunta(imgPreg: UIImage(named: "default"))
            }
            
            let imgsArr = pregDoc["imagenes"] as? [String]
            
            for k in 0...imgsArr!.count-1 {
                url = URL(string: imgsArr![k])
                imgRespData = NSData(contentsOf: url!)
                nuevaPregunta.imagenes.append(UIImage(data: imgRespData! as Data)!)
            }
            
            listaCuestionarios[index].preguntas.append(nuevaPregunta)
            j += 1
        }
        tableView.reloadData()
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return listaCuestionarios.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "idCellCuestionario", for: indexPath)

        cell.textLabel?.text = listaCuestionarios[indexPath.row].nombre
        return cell
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        let indexPath = tableView.indexPathForSelectedRow!
        
        let view = segue.destination as! DetalleCuestionario
        view.cuestionarioSeleccionado = listaCuestionarios[indexPath.row]
    }
    
    @IBAction func regresarPantalla(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
}
