''' 
student_stats.py takes the student's name as the input as gives bar graph of 
the student's percentiles in all the exams

'''
import sys
import numpy as nd
import matplotlib.pyplot as plt

roll_num=sys.argv[1]
exam=nd.array([])
percentiles=nd.array([])
marks=[]
stu_less=[]
stu_num=-1
z=0

file=open("main.csv","r")
# storing the marks of the student of input roll number
for line in file :
    stu_num=stu_num+1
    arr=line.split(",")
    z=len(arr)
    if arr[0]==roll_num :
        for k in range(2,len(arr)):
            if (arr[k] != "a") and (arr[k] != "a\n"):
                marks.append(arr[k])
            else :
                marks.append(0)
            
#initializing an array which will store the number of students with lesser marks than the input student in each exam
for k in range(0,z-2):
    stu_less.append(0)


file=open("main.csv","r")
for line in file :
    arr=line.split(",")
    #storing the exam names
    if arr[0]=="Roll_Number" :
        for k in range(2,len(arr)):
            exam=nd.append(exam,arr[k])
    #storing the number of students scoring less than input student
    else :
        for k in range(2,len(arr)):
            if (arr[k] != "a") and (arr[k] != "a\n"):
                if int(marks[k-2]) >= int(arr[k]):
                    stu_less[k-2]=stu_less[k-2]+1
            else :
                stu_less[k-2]=stu_less[k-2]+1

#calculating percentiles
for k in range(0,z-2):
    per=(float(stu_less[k])/stu_num)*100
    percentiles=nd.append(percentiles,round(per,2))

print(percentiles)
#visualisation
plt.bar(exam,percentiles)
plt.xlabel("Exam")
plt.ylabel("Percentile")
plt.show()


        
