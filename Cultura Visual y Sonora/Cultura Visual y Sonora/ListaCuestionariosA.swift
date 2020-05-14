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
            
            //obtenerPreguntas(addPreguntas, nombre: nombre, i:i)
            
            i+=1
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
