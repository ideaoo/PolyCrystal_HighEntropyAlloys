fo1 = open('Read04_一讀.txt','r')
C=[]
for line in fo1:
    strr = line[21:71]
    A =[]
    for s in strr:
        if s==' ':
            s = 0
            A.append(s)
        else:
            s =1
            A.append(s)
    C.append(A)

    
fo2 = open('Read04_二讀.txt','r')
D=[]
for line2 in fo2:
    strr2 = line2[21:71]
    E =[]
    for s2 in strr2:
        if s2==' ':
            s2 = 0
            E.append(s2)
        else:
            s2 =1
            E.append(s2)
    D.insert(0,E)
    
step = 5
testresult = []
C1 = []
for row in C :
    c = [row[n:n+step] for n in range(0,len(row),step)]
    C1.append(c)

D1 = []
for row2 in D :    
    d = [row2[y:y+step] for y in range(0,len(row2),step)]
    D1.append(d)

for m in range(0,len(C)):
    N = []
    for n in range(0,len(C1[0])):
       
        if C1[m][n]== D1[m][n]:
            n = 1
            N.append(n)
        else:
            n = 0
            N.append(n)
    testresult.append(N)

        
    

fo1 = open('Read04_一讀.txt','r')
testnumber =[]
for line in fo1:
    number = line[7:16]
    testnumber.append(number)
EnRead = []
for element in range(0,len(testnumber)):
    result = ['考生編號',testnumber[element],'相同與否',testresult[element]]
    EnRead.append(str(result))
for x in EnRead:
    print(x)
    



    