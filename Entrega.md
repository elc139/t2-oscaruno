# T2: Programação Paralela Multithread

-   **Aluno**: Deivis Costa Pereira.
-   **Disciplina**: ELC139 - Programação Paralela.

## PThreads

### Questão 1
Tendo em vista que o programa a ser analisado é uma implementação para calculo de produto escalar.
1. Particionamento

    O particionamento é realizado na linha [41](https://github.com/elc139/t2-oscaruno/blob/5116f9ea18fa4661d6c8f466d41a440008d7cc26/pthreads_dotprod/pthreads_dotprod.c#L41):
    ``` c
    mysum += (a[i] * b[i]);
    ```
    Pelo fato de cada multiplicação a[i]*b[i] poder ocorrer em paralelo.
2. Comunicação

    A comunicação, soma das somas parciais, é realizada na linha [46](https://github.com/elc139/t2-oscaruno/blob/5116f9ea18fa4661d6c8f466d41a440008d7cc26/pthreads_dotprod/pthreads_dotprod.c#L46) dentro de uma região crítica:
    ``` c
    pthread_mutex_lock (&mutexsum);
    dotdata.c += mysum;
    pthread_mutex_unlock (&mutexsum);
    ```
3. Aglomeração

    Os produtos(multiplicações) são aglomeradas/juntados/somados em um laço, com o tamanho wsize, linha [40](https://github.com/elc139/t2-oscaruno/blob/5116f9ea18fa4661d6c8f466d41a440008d7cc26/pthreads_dotprod/pthreads_dotprod.c#L40):
    ``` c
    for (i = start; i < end ; i++)  {
        mysum += (a[i] * b[i]);
    }
    ```
4. Mapeamento

    O mapeamento é feito de forma estática, onde cada thread executa o mesmo tamanho de cálculos/elementos, o qual é dado como argumento do programa, linha [68](https://github.com/elc139/t2-oscaruno/blob/5116f9ea18fa4661d6c8f466d41a440008d7cc26/pthreads_dotprod/pthreads_dotprod.c#L68):
    ``` c
    for (i = 0; i < nthreads; i++) {
        pthread_create(&threads[i], &attr, dotprod_worker, (void *) i);
    }
    ```
### Questão 2
- **1 Thread**: 5212472 usec
- **2 Threads**: 2672517 usec
- **Aceleração**: 1.95x *(t1/t2)*
### Questão 3

### Questão 4
| size     | repetitions | threads | usec(média)     | speedup_pthread | 
| :---:    | :---:       | :---:   |:---:            |:---:            |
| 1000000  | 4000        | 1       | 10427933        | -               |
| 500000   | 4000        | 2       | 5848390         | 1.783043367     |
| 250000   | 4000        | 4       | 4241710         | 2.458426672     |
| 2000000  | 3000        | 1       | 16270083        | -               |
| 1000000  | 3000        | 2       | 9483107         | 1.715691176     |
| 500000   | 3000        | 4       | 6329449         | 2.570537025     |
| 3000000  | 2000        | 1       | 15665112        | -               |
| 1000000  | 2000        | 2       | 9502017         | 1.648609132     |
| 500000   | 2000        | 4       | 6428893         | 2.436673312     |
| 4000000  | 1000        | 1       | 10656197        | -               |
| 2000000  | 1000        | 2       | 6391912         | 1.667137626     |
| 1000000  | 1000        | 4       | 4259779         | 2.501584472     |

### Questão 5

## OpenMP

## Referências
