using System;
class TabelaHash{
    private int[] array;
    private int n;
    private const int VAZIO = -1;
    private const int DEL = -2;

    public TabelaHash(int m){        
        array = new int[m];
        for (int i = 0; i < m; i++)
            array[i] = VAZIO;

        n = 0;        
    }

    private int FuncHashAux(int k){        
        return k;
    }
    private int FuncHash(int k, int i){        
        return (FuncHashAux(k) + i) % array.Length;
    }

    public void Inserir(int k) {
        if (n >= array.Length)
            throw new Exception("tabela cheia!");
        
        int i = 0, pos;

        do{
            pos = FuncHash(k, i);

            if (array[pos] == k)
                throw new Exception("elemento já consta!");            
            else if (array[pos] == VAZIO || array[pos] == DEL) {
                array[pos] = k;
                break;
            }
            else {
                i++;
            }

        } while (i < array.Length);
    }

    public void Remover(int k) {
        int i = 0;
        int pos;
        
        do {
            pos = FuncHash(k, i);

            if (array[pos] == k) //encontrou
                array[pos] = DEL;
                break;
            else
                i++;

        } while (i < array.Length);
    }

    public void Pesquisar(int k) {
        int i = 0;
        int pos;

        do {
            pos = FuncHash(k, i);

            if (array[pos] == k)
                Console.WriteLine("está cadastrado!");
            else if (array[pos] == VAZIO || array[pos] == DEL)
                i++;

        } while (i < array.Length);
    }    
}
class Program{
    static void Main(string[] args){
        
    }
}