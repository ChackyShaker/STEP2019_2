import numpy, sys, time

if (len(sys.argv) != 2):
    print("usage: python %s N" % sys.argv[0])
    quit()

n = int(sys.argv[1])#行数/列数の決定
a = numpy.zeros((n, n)) # Matrix A
b = numpy.zeros((n, n)) # Matrix B
c = numpy.zeros((n, n)) # Matrix C

# Initialize the matrices to some values.
for i in range(n):
    for j in range(n):
        a[i, j] = i * n + j
        b[i, j] = j * n + i
        c[i, j] = 0

#print(a[0][0])
#print(a[0][1])
#print(a[0][2])
begin = time.time()

#c_true = numpy.dot(a,b)
#print("c_true",c_true)

######################################################
# Write code to calculate C = A * B                  #
# (without using numpy librarlies e.g., numpy.dot()) #

for i in range(a.shape[0]):
    for j in range(b.shape[1]):
        for k in range(a.shape[1]):
            c[i, j] += a[i, k] * b[k, j]
#print("c_test", c)　500 140.601606 sec

#for i in range(n):
#    for j in range(n):
#        for k in range(n):
#            c[i, j] += a[i, k] * b[k, j]
#print("c_test", c) 500 262.188094 sec

######################################################


end = time.time()
print("time: %.6f sec" % (end - begin))#%.~どうやって表示させたいか/小数点（float）6桁まで

# Print C for debugging. Comment out(プログラムのある行を#にする） the print before measuring the execution time.
total = 0
for i in range(n):
    for j in range(n):
        #print(c[i, j])
        total += c[i, j]
# Print out the sum of all values in C.
# This should be 450 for N=3, 3680 for N=4, and 18250 for N=5.
print("sum: %.6f" % total)




