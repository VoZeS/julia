using Printf
using LinearAlgebra
#Declaramos la matriz A (despues sera en un .txt)
A=[3 2 3; 4 4 3;-1 4 4]
x=0
num=0
#Imprimimos la matriz por pantalla
for i=1:3
    for j=1:3
        global A
        print(A[i,j], " ")
    end
    print("\n")
end

print("\n")

#Empezamos con la triangulación de la matriz
#j -> Filas, i -> Columnas
# : -> hasta el final
for i=1:3
    for j=i+1:3
        global A
        global num
        #Guardamos el elemento que queremos que sea 0 para poderlo imprimir en
        #los pasos que hace el programa para triangular la matriz
        num=A[j,i]

        #Si el elemento que queremos convertir en 0 no es 0, se multiplica la
        #fila del pivote por este, y la fila del elemento por el pivote
        if(A[j,i] != 0)
            A[j,:]=A[i,i]*A[j,:]-A[j,i]*A[i,:]
        end
        println()
        global x

        #Imprimimos los pasos y las operaciones realizadas
        x+=1
        println("Pas ", x, ": ")
        println("F",j,"= ", A[i,i], "*F",j," - ", num, "*F",i)
        println()

        #Imprimimos la matriz con las operaciones realizadas
        for i=1:3
            for j=1:3
                global A
                print(A[i,j], " ")
            end
            print("\n")
        end
    end
end

println()
#Imprimimos la matriz triangulada
println("Resultado Triangulado:")
for i=1:3
    for j=1:3
        global A
        print(A[i,j], " ")
    end
    print("\n")
end
