import sys
import numpy as nd
import matplotlib.pyplot as plt

exam_file=sys.argv[1]
marks_arr=nd.array([])
file=open(exam_file,"r")
#getting everyone's marks in that exam
for line in file:
    arr=line.split(",")
    if (arr[2] != "Marks\n"):
        marks_arr=nd.append(marks_arr,int(arr[2]))
#statistics
print("Average : ",nd.mean(marks_arr))
print("Median : ",nd.median(marks_arr))
print("Standard Deviation : ",nd.std(marks_arr))
#visualisation(number of students vs marks)
plt.hist(marks_arr)
plt.xlabel("Marks")
plt.ylabel("No. of students")
plt.show()
