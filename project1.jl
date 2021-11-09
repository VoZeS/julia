using Printf
using LinearAlgebra
A=[3 2 3; 4 4 3;1 4 4]
println(det(A))

for i=1:3
    for j=1:3
        global A
        print(A[i,j], " ")
    end
    print("\n")
end

print("\n")

for i=1:3
    for j=i+1:3
        global A
        if(A[j,i] != 0)
            A[j,:]=A[j,i]*A[i,:]-A[i,i]*A[j,:]
        end
        if(A[j,i] < 0 && A[i,i])
            A[j,:]=A[j,i]*A[i,:]+A[i,i]*A[j,:]
        end
    end
end

for i=1:3
    for j=1:3
        global A
        print(A[i,j], " ")
    end
    print("\n")
end
