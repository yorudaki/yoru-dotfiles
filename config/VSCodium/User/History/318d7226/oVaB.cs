using System;
class TabelaHash{
    private int[] array;
    private int n;

    public TabelaHash(int n){
        this.n = n;
        array = new int[n];
    }

    private int FuncHash(string elemento){
        int chave = 0;
        foreach (char letra in elemento){
            chave += letra;
        }       
    }
}
class Program{
    static void Main(string[] args){
        Console.Write("hello world");
    }
}