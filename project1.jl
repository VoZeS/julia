using Printf
using LinearAlgebra

#We declare the A matrix (despues sera en un .txt)
#file=open("nom del arxiu.txt")
#matrix=readdlm(file)

A=[1 2 3; 0 1 4;5 6 0]
I=[1 0 0; 0 1 0; 0 0 1]
B= hcat(A,I)
x=0
num=0
#definimos n para recorrer el for de 3 a 1
n=3
#We print the matrix in the screen
println("A:")
for i=1:3
    for j=1:3
        global A
        print(A[i,j], " ")
    end
    print("\n")
end

print("\n")
println("A|I:")
for i=1:3
    for j=1:6
        global A
        global I
        print(B[i,j], " ")
    end
    print("\n")
end
print("\n")

#Triangulation start
#j -> Rows, i -> Columns
# : -> till the end
for i=1:3
    for j=i+1:3
        global B
        global num
        #We save the element we want to transform to 0 to print it later (when
        #show the resolution steps)
        #los pasos que hace el programa para triangular la matriz
        num=B[j,i]

        #Si el elemento que queremos convertir en 0 no es 0, se multiplica la
        #fila del pivote por este, y la fila del elemento por el pivote
        if(B[j,i] != 0)
            B[j,:]=B[i,i]*B[j,:]-B[j,i]*B[i,:]
        end
        println()
        global x

        #Imprimimos los pasos y las operaciones realizadas
        x+=1
        println("Pas ", x, ": ")
        println("F",j,"= ", B[i,i], "*F",j," - ", num, "*F",i)
        println()

        #Imprimimos la matriz con las operaciones realizadas
        for i=1:3
            for j=1:6
                global A
                print(B[i,j], " ")
            end
            print("\n")
        end
    end
end

#Triangulamos el triangulo superior
#j -> Filas, n -> Columnas i-> auxiliar de "n"
# : -> hasta el final
#"i" nos sirve para restar las columnas e ir de la 3 a la 2: primero resta 0 a "n"
#para que la fila sea 3, y despues restamos 1 para que "n" sea 2
for i=0:1
    #hacemos la operacion de arriba
    for n=n-i
        for k=0:1
            #Comprovant de que j no sigui 0 i surti de la matriu
            if(n-k>1)
                for j=n-k-1
                    global B
                    global num
                    #Guardamos el elemento que queremos que sea 0 para poderlo imprimir en
                    #los pasos que hace el programa para triangular la matriz
                    num=B[j,n]

                    #Si el elemento que queremos convertir en 0 no es 0, se multiplica la
                    #fila del pivote por este, y la fila del elemento por el pivote
                    if(B[j,n] != 0)
                        B[j,:]=B[n,n]*B[j,:]-B[j,n]*B[n,:]
                    end
                    println()
                    global x

                    #Imprimimos los pasos y las operaciones realizadas
                    x+=1
                    println("Pas ", x, ": ")
                    println("F",j,"= ", B[n,n], "*F",j," - ", num, "*F",n)
                    println()

                    #Imprimimos la matriz con las operaciones realizadas
                    for i=1:3
                        for j=1:6
                            global B
                            print(B[i,j], " ")
                        end
                        print("\n")
                    end
                end
            end
        end
    end
end

println()
#Imprimimos la matriz triangulada
println("Resultado Triangulado:")
for i=1:3
    for j=1:6
        global B
        print(B[i,j], " ")
    end
    print("\n")
end

print("\n")
println("MATRIZ IDENTIDAD|MATRIZ INVERSA:")
#Imprimimos la matriz I|A-1 con las operaciones realizadas
for i=1:3
    y=B[i,i]
    for j=1:6
        global B
        print(B[i,j]/y, " ")
    end
    print("\n")
end
