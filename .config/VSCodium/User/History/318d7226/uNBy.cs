using System;
class TabelaHash{
    private int[] array;
    private int n;
    private const int VAZIO = -1;
    private const int DEL = -2;

    public TabelaHash(int n){
        this.n = n;
        array = new int[n];
        for (int i = 0; i < n; i++)
            array[i] = VAZIO;        
    }

    private int FuncHashAux(string elemento){
        int chave = 0;        
        foreach (char letra in elemento)
            chave += letra;                

        return chave;
    }
    private int FuncHash(string elem, int i){
        int k = FuncHashAux(elem);
        return (k + i) % n;
    }
}
class Program{
    static void Main(string[] args){
        
    }
}