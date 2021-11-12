using Printf
using LinearAlgebra
using DelimitedFiles

#File opening and reading matrix and vor together
A=readdlm("matriu.txt", Float64)

#Reading and saving matrix size
s=size(A)
s1=s[1] #rows
s2=s[2] #columns

#Vector separation in a new variable
v=copy(A[s1,:])
A=A[setdiff(1:end, s1), :]

#Getting new matrix size
s=size(A)
s1=s[1]

#A=[1.0 2.0 3.0; 3.0 2.0 1.0;1.0 0.0 1.0]
if(s1==2)
    I=[1.0 0.0; 0.0 1.0]
end
if(s1==3)
    I=[1.0 0.0 0.0; 0.0 1.0 0.0; 0.0 0.0 1.0]
end
if(s1==4)
    I=[1.0 0.0 0.0 0.0; 0.0 1.0 0.0 0.0; 0.0 0.0 1.0 0.0; 0.0 0.0 0.0 1.0]
end
mB= hcat(A,I)
x=0
num=0

IFsort=0
#We initialize C to some random numbers which will be A's reverse
C=rand(s1,s2)

#We initialize X to some random numbers which will be the result of Ax = B
X=rand(s1,1)

#We define n as an auxiliar to be able to run the for from 3 to 1
n=3

#We define the "sort" function
function sort(mB, s1, s2, IFsort)
    for i=1:s1
        for j=1:s2
            if(mB[i,i] == 0.0)
                u=1
                for u=1:s2
                    if(mB[i,u]!=0.0)
                        aux=mB[i,:]
                        mB[i,:]=mB[u,:]
                        mB[u,:]=aux
                        IFsort=1
                        #println("F",i,"<->", "F",u)
                        #println()
                    end
                end
            end
        end
    end
end


#We print the matrix in the screen
println("A:")
for i=1:s1
    global s2
    for j=1:s2
        global A
        print(A[i,j], " ")
    end
    print("\n")
end

print("\n")
println("A|I:")
for i=1:s1
    global s2
    for j=1:s2*2
        global A
        global I
        print(mB[i,j], " ")
        if (j==3)
            print("\t| ")
        end
    end
    print("\n")
end
print("\n")

#Triangulation start
#j -> Rows, i -> Columns
# : -> till the end
for i=1:s1
    global s2
    for j=i+1:s2
        global mB
        global s1
        global num
        #We save the element we want to transform to 0 to print it later (when
        #show the resolution steps)
        #the steps that theprogram does to triangulate the matrix
        num=mB[j,i]

        sort(mB, s1, s2, IFsort)

        #If the element that we want to convert in 0 it is not 0, it
        #multiplies the row of the pivot by this one, and the row of the element
        #by the pivot
        if(mB[j,i] != 0)
            mB[j,:]=mB[i,i]*mB[j,:]-mB[j,i]*mB[i,:]
        end
        println()
        global x

        #We print the steps and the done operations
        x+=1
        println("Pas ", x, ": ")
        println("F",j,"= ", mB[i,i], "*F",j," - ", num, "*F",i)
        println()


        #We print the steps and the done operations
        for i=1:3
            global s2
            for j=1:s2*2
                global A

                print(mB[i,j], " ")
                if (j==s2)
                    print("\t| ")
                end
            end
            print("\n")
        end
    end
    global IFsort
    
    if (IFsort==1)
        IFsort=0
        i=1
    end
end

#We triangulate the top triangle
#j -> rows, n -> Columns i-> auxiliary of "n"
# : -> untill the end
#We use "i" to substract the columns and go from the third to the second one:
#start substracting 0 to "n" so the row it is 3 and later the substraction
# is 1 so "n" is 2
for i=0:s1-2
    #We do the top operation
    for n=n-i
        global s1
        for k=0:s1-2
            #Checking that "j" it is not 0 and gets out of the matrix
            if(n-k>1)
                for j=n-k-1
                    global mB
                    global num
                    global IFsort

                    #We save the element that we want it to be 0 so we can print
                    # it in the steps that the program does to
                    #triangulate the matrix
                    num=mB[j,n]

                    sort(mB, s1,s2, IFsort)
                    if(IFsort==1)
                        IFsort=0
                        i=0
                    end

                    #If the element that we want to convert to 0 it is not 0,
                    #it multiplies the pivot's row by this one and the
                    #elements's row by the pivot
                    if(mB[j,n] != 0)
                        mB[j,:]=mB[n,n]*mB[j,:]-mB[j,n]*mB[n,:]
                    end
                    println()
                    global x

                    #We print the steps and done operations
                    x+=1
                    println("Pas ", x, ": ")
                    println("F",j,"= ", mB[n,n], "*F",j," - ", num, "*F",n)
                    println()

                    #We print the steps and done operations
                    for i=1:s1
                        global s2
                        for j=1:s2*2
                            global mB
                            print(mB[i,j], " ")
                            if (j==s2)
                                print("\t| ")
                            end
                        end
                        print("\n")
                    end
                end
            end
        end
    end
end

println()
#We print the triangulated matrix
println("Resultado Triangulado:")
for i=1:s1
    global s2
    for j=1:s2*2
        global mB
        print(mB[i,j], " ")
        if (j==s2)
            print("\t| ")
        end
    end
    print("\n")
end

print("\n")
println("MATRIZ IDENTIDAD|MATRIZ INVERSA:")
#We print the matrixI|A^-1 with the done operations
for i=1:s1
    y=mB[i,i] #"y" saves the pivots ([1,1],[2,2],[3,3])
    global s2
    for j=1:s2*2
        global mB
        mB[i,j]=mB[i,j]/y
        print(mB[i,j], " ")
        if (j==s2)
            print("\t| ")
        end
    end
    print("\n")
end

print("\n")
println("MATRIZ INVERSA RESULTANTE (A^-1)")

#We split the reverse matrix form the total and save it ina a new variable
for i=1:s1
    global s2
    for j=1:s2*2
        global mB
        global C
        if (j>s2)
            C[i,j-s2]=mB[i,j]
        end
    end
end

for i=1:s1
    global s2
    for j=1:s2
        global C
        #We printthe matrix C, which is the A's reverse
        print(C[i,j], " ")
    end
    print("\n")
end


println()
#We print the vect in the screen
println("b:")
for i=1:s1
    print(v[i,1], " ")
    print("\n")
end

print("\n")
println("WE SOLVE Ax=b")
X=C*v
print("X = (A^-1)*b\n")
println()

print("X:\n")

for i=1:s1
    print(X[i,1])
    print("\n")
end
