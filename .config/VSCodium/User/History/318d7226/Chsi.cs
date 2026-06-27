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
                n++;
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

            if (array[pos] == k) {  //encontrou
                array[pos] = DEL;
                n--;
                break;
            }
            else
                i++;

        } while (i < array.Length);

        if (i >= array.Length);
            Console.WriteLine("não encontrado");
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

        if (i >= array.Length);
            Console.WriteLine("não encontrado");
    }    
}
class Program{
    static void Main(string[] args){
        var table = new TabelaHash(37);
        int op = 0;

        while (op != 4) {
            Console.WriteLine("op: ");
            op = int.Parse(Console.ReadLine());

            switch (op) {
                case 1:
                    table.Inserir(int.Parse(Console.ReadLine()));
                break;
                case 2:
                    table.Remover(int.Parse(Console.ReadLine()));
                break;
                case 3:
                    table.Pesquisar(int.Parse(Console.ReadLine()));
                case 4:
                break;
                default: break;
            }
        }
    }
}