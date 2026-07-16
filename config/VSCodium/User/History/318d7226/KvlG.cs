using System;
class Program{
    static void PrintArray(int[] array){        
        for (int i = 0; i < array.Length; i++){            
            Console.Write($"{array[i]} - ");
        }
        Console.WriteLine("");
    }

    static void SelectionSort(int[] array){
        /*
        ESTAVEL
        LOGICA:
            Variável guarda a posição do menor elemento do vetor. (Inicialmente é o primeiro elemento do vetor);
            Percorre o vetor, se encontrar algum elemento menor, posicaoMenor guarda a posição do novo menor;
            Realiza a troca entre o elemento base e o menor com auxilio de uma variavel temporaria;
            Tudo isso em loop até o fim o vetor.
        */
        int temp, imenor;

        for (int i = 0; i < array.Length; i++){
            imenor = i;
            
            for (int j = i+1; j < array.Length; j++){
                if (array[imenor] > array[j])
                    imenor = j;                
            }

            temp = array[imenor];
            array[imenor] = array[i];
            array[i] = temp;
        }
    }
    static void BubbleSort(int[] array){
        /* 
        ESTAVEL
        LOGICA:
            Percorre array (double for) fim até inicio
            Troca se elemento < elemento-1
            Primeiro loop (inicio até fim) define até onde o vetor está ordenado
        */
        int temp;
        for (int i = 0; i < array.Length; i++){
            for (int j = array.Length-1; j > i; j--){
                if (array[j] < array[j-1]){
                    temp = array[j-1];
                    array[j-1] = array[j];
                    array[j] = temp;
                }
            }
        }
       
    }
    static void InsertionSort(int[] array){
        /*
        ESTAVEL
        MELHOR CASO: Quase ordenado
        LOGICA
            dividido. inicio = ordenado, resto = bruto
            elemento em variavel temporaria
            demais elementos são movidos para "abrir espaço"            
        */
        int temp, j;
        for (int i = 1; i < array.Length; i++){ 
            temp = array[i]; // alvo = elemento a ser ordenado
            j = i - 1; // elemento anterior ao alvo

            while ((j >= 0) && (array[j] > temp)){ // vai deslocando até achar um elemento menor que o alvo
                array[j+1] = array[j]; // desloca o da esquerda pra direita
                j--; 
            }
            array[j+1] = temp; // coloca o alvo no lugar. saiu do while = j+1 é a posição a ser usada.

        }
    }
    static void MergeSort(int[] array){
        
    }
    
    static void Main(string[] args){
        int[] array = new int[50];
        int algorithm;
        Random rnd = new Random();
        // ENCHENDO ARRAY
        for (int i = 0; i < array.Length; i++) {
            array[i] = rnd.Next(1, 1000);
        }     
        Console.WriteLine("ORIGINAL:");
        PrintArray(array);

        algorithm = 3;
        switch (algorithm){
            case 1:
            SelectionSort(array);
            break;
            case 2:
            BubbleSort(array);
            break;
            case 3:
            InsertionSort(array);
            break;
            default: break;
        }
        
        Console.WriteLine("\nSORTED:");
        PrintArray(array);        

    }
}