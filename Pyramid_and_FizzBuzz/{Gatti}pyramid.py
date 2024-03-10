stacks = int(input("How tall should the pyramid be? "))
if stacks > 8:
    print("Exceeded maximum pyramid height")
else :
    for i in range(stacks):
        for j in range(stacks - i):
            print(" ", end='')
        for k in range(i+1):
            print("#", end='')
        print()

