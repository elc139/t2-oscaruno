# T2: Programação Paralela Multithread

-   **Aluno**: Deivis Costa Pereira.
-   **Disciplina**: ELC139 - Programação Paralela.

## PThreads

### Questão 1

Tendo em vista que o programa a ser analisado é uma implementação para calculo de produto escalar.

1. Particionamento

    O particionamento é realizado na linha [41](https://github.com/elc139/t2-oscaruno/blob/master/pthreads_dotprod/pthreads_dotprod.c#L41):

    ```c
    mysum += (a[i] * b[i]);
    ```
    Pelo fato de cada multiplicação a[i]\*b[i] poder ocorrer em paralelo.

2. Comunicação

    A comunicação, soma das somas parciais, é realizada na linha [46](https://github.com/elc139/t2-oscaruno/blob/master/pthreads_dotprod/pthreads_dotprod.c#L46) dentro de uma região crítica:
    ```c
    pthread_mutex_lock (&mutexsum);
    dotdata.c += mysum;
    pthread_mutex_unlock (&mutexsum);
    ```

3. Aglomeração

    Os produtos(multiplicações) são aglomeradas/juntados/somados em um laço, com o tamanho wsize, linha [40](https://github.com/elc139/t2-oscaruno/blob/master/pthreads_dotprod/pthreads_dotprod.c#L40):
    ```c
    for (i = start; i < end ; i++)  {
        mysum += (a[i] * b[i]);
    }
    ```

4. Mapeamento

    O mapeamento é feito de forma estática, onde cada thread executa o mesmo tamanho de cálculos/elementos, o qual é dado como argumento do programa, linha [68](https://github.com/elc139/t2-oscaruno/blob/master/pthreads_dotprod/pthreads_dotprod.c#L68):
    ```c
    for (i = 0; i < nthreads; i++) {
        pthread_create(&threads[i], &attr, dotprod_worker, (void *) i);
    }
    ```
### Questão 2

-   **1 Thread**: 5212472 usec
-   **2 Threads**: 2672517 usec
-   **Aceleração**: 1.95x _(t1/t2)_

### Questão 3
A aceleração se sustentou para outros casos de teste. Em torno de **1.6x** com o uso de **2 threads** e de **2.5x** com o uso de **4 threads**. Cada caso de teste foi executado **4x**, utilizou-se o [script](https://github.com/elc139/t2-oscaruno/blob/master/script.sh) para automatizar os testes.

### Questão 4

|  size   | repetitions | threads | usec(média) | speedup |
| :-----: | :---------: | :-----: | :---------: | :-----: |
| 1000000 |    4000     |    1    |   9947524   | 1.0000  |
| 500000  |    4000     |    2    |   5501078   | 1.8082  |
| 250000  |    4000     |    4    |   3895448   | 2.5536  |
| 2000000 |    3000     |    1    |  14931169   | 1.0000  |
| 1000000 |    3000     |    2    |   8845348   | 1.6880  |
| 500000  |    3000     |    4    |   5921178   | 2.5216  |
| 3000000 |    2000     |    1    |  14942139   | 1.0000  |
| 1500000 |    2000     |    2    |   8868552   | 1.6848  |
| 750000  |    2000     |    4    |   5937212   | 2.5166  |
| 4000000 |    1000     |    1    |  10512969   | 1.0000  |
| 2000000 |    1000     |    2    |   6232070   | 1.6869  |
| 1000000 |    1000     |    4    |   4302982   | 2.4431  |

### Questão 5
A única diferença entre os programas se dá na ausência das linhas 45 e 47:
``` c
pthread_mutex_lock (&mutexsum);   // LINHA 45
dotdata.c += mysum;               // LINHA 46
pthread_mutex_unlock (&mutexsum); // LINHA 47
```
no programa [pthreads_dotprod2.c](https://github.com/elc139/t2-oscaruno/blob/master/pthreads_dotprod/pthreads_dotprod2.c), as quais teriam a responsabilidade do acesso à área crítica do programa. Tendo em vista que o operador **+=** implementa três instruções, leitura, soma e escrita, existe a possibilidade da thread1 ler um valor, ser escalonada, outra thread2 completar essas 3 instruções, e o valor incrementado pela thread1 se tornar inconsistente. 

## OpenMP

## Referências
- Assignment Operators:

    https://en.cppreference.com/w/c/language/operator_assignment
- C11 standard (ISO/IEC 9899:2011). *6.5.16* Assignment operators (p: 101-104)
- SEBOR, Martin. Toward a Better Use of C11 Atomics – Part 1.

    https://developers.redhat.com/blog/2016/01/14/toward-a-better-use-of-c11-atomics-part-1/