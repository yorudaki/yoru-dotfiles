using System;
class No{
    private int elemento;
    private No esq;
    private No dir;

    public No (int elemento){
        this.elemento = elemento;
        esq = null;
        dir = null;
    }

    public int Elemento {get{return elemento;} set{this.elemento = value}}
    public No Esq {get{return esq;} set{this.esq = value;}}
    public No Dir {get{return dir;} set{this.dir = value;}}
}
class Arvore{
    private No raiz;

    public Arvore(){
        raiz = null;
    }

    public void Inserir (int elemento){
        raiz = Inserir(elemento, raiz);
    }
    private No Inserir (int elemento, No raiz){
        if (raiz == null){
            raiz = new No(elemento);
        }
        else if (PESQUISAR_ELEM){
            throw new Exception("elemento já existe");
        }
        else if (elemento > raiz.Elemento){
            raiz = Inserir(elemento, raiz.Dir);
        }
        else{
            raiz = Inserir(elemento, raiz.Esq);
        }
    }

    public bool Pesquisar (int elemento){        
        return Pesquisar (elemento, raiz);
    }
    private bool Pesquisar (int elemento, No raiz){
        bool resp;
        if (elemento == raiz.Elemento){
            resp = true;
        }
        else if (elemento > raiz.Elemento){
            resp = Pesquisar(elemento, raiz.Dir);
        }
        else if (elemento < raiz.Elemento){
            resp = Pesquisar(elemento, raiz.Esq);
        }
        else{
            resp = false;
        }

        return resp;
    }
    public void Remover(int elemento){
        raiz = Remover(elemento, raiz);
    }
    private No Remover(int elemento, No raiz){
                
    }
    
}
class Program{
    static void Main(string[] args){

    }
}