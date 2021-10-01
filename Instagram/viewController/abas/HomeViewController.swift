//
//  HomeViewController.swift
//  Instagram
//
//  Created by Jamilton  Damasceno
//  Copyright © Curso IOS. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth
import FirebaseUI

class HomeViewController: UIViewController,
    UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableViewPostagens: UITableView!
    var firestore: Firestore!
    var auth: Auth!
    var postagens: [Dictionary<String, Any>] = []
    var idUsuarioLogado: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewPostagens.separatorStyle = .none
        
        firestore = Firestore.firestore()
        auth = Auth.auth()
        
        if let idUsuario = auth.currentUser?.uid {
            self.idUsuarioLogado = idUsuario
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        recuperarPostagens()
    }
    
    func recuperarPostagens(){
        
        //Limpa listagem de postagens
        self.postagens.removeAll()
        self.tableViewPostagens.reloadData()
        
        firestore.collection("postagens")
        .document(idUsuarioLogado)
        .collection("postagens_usuario")
            .getDocuments { (snapshotResultado, erro) in
                
                if let snapshot = snapshotResultado {
                    for document in snapshot.documents {
                        let dados = document.data()
                        self.postagens.append(dados)
                    }
                    self.tableViewPostagens.reloadData()
                }
                
        }
        
    }
    
    /*Métodos para listagem na tabela*/
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.postagens.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let celula = tableView.dequeueReusableCell(withIdentifier: "celulaPostagens", for: indexPath) as! PostagemTableViewCell
        
        let indice = indexPath.row
        let postagem = self.postagens[indice]
        
        let descricao = postagem["descricao"] as? String
        if let url = postagem["url"] as? String {
            celula.fotoPostagem.sd_setImage(with: URL(string: url), completed: nil)
        }
        
        celula.descricaoPostagem.text = descricao
        //celula.fotoPostagem.image = UIImage(named: "padrao")
        
        return celula
        
    }

}
