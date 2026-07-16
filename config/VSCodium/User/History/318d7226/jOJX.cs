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

    public int Elemento {get{return elemento;} set{this.elemento = value;}}
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
        else if (elemento > raiz.Elemento){
            raiz.Dir = Inserir(elemento, raiz.Dir);
        }
        else if (elemento < raiz.Elemento){
            raiz.Esq = Inserir(elemento, raiz.Esq);
        }
        else
        {
            throw new Exception("elemento já existe");
        }

        return raiz;
    }

    public bool Pesquisar (int elemento){        
        return Pesquisar (elemento, raiz);
    }
    private bool Pesquisar (int elemento, No raiz){
        bool resp = false;
        if (elemento == raiz.Elemento){
            resp = true;
        }
        else if (elemento > raiz.Elemento){
            resp = Pesquisar(elemento, raiz.Dir);
        }
        else if (elemento < raiz.Elemento){
            resp = Pesquisar(elemento, raiz.Esq);
        }        

        return resp;
    }
    public void Remover(int elemento){
        raiz = Remover(elemento, raiz);
    }
    private No Remover(int elemento, No raiz){
        // Procurar elemento
        if (elemento < raiz.Elemento){
            raiz.Esq = Remover(elemento, raiz.Esq);
        }
        else if (elemento > raiz.Elemento){
            raiz.Dir = Remover(elemento, raiz.Dir);
        }
        // "Remoção"
        else if (raiz.Dir == null){
            raiz = raiz.Esq;
        }
        else if (raiz.Esq == null){
            raiz = raiz.Dir;
        }
        else{
            raiz = GetMaiorEsq(raiz, raiz.Esq);
        }
        return raiz;
    }
    private No GetMaiorEsq(No i, No esq){
        // achou o elemento mais a direita:
        // coloca o elemento de ESQ no I
        // substitui o ESQ com o elemento à esquerda de ESQ
        if (esq.Dir == null){
            i.Elemento = esq.Elemento;
            esq = esq.Esq;
        }
        // pula para o próximo à direita
        else {
            esq.Dir = GetMaiorEsq(i, esq.Dir);
        }
        return esq;
    }    
}
class Program{
    static void Main(string[] args){
        var arvore = new Arvore();

        arvore.Inserir(5);
        arvore.Inserir(9);
        arvore.Inserir(1);
        arvore.Inserir(2);
        arvore.Inserir(8);

        Console.WriteLine(arvore.Pesquisar(5) ? "existe" : "nao existe");

        arvore.Remover(5);

        Console.WriteLine(arvore.Pesquisar(5) ? "existe" : "nao existe");
    }
}