#Name:
#ID:




#--------- Write your code below this line--------------------------
i =1
num=None
# set sum to start with 0
sum=0
# set pruduct as 1
product=1
# set final sum to 0
final_sum=0
while(i<=10 and num!=0 ):
    # input n
    num=int(input("Enter a number or zero to stop: "))
    # add n to sum
    sum=sum+num
    if num!=0: # if number 
        product=product*num
    # increase i by 1 to keep track of no of inputs
    i=i+1
# calculate answer
final_sum=sum+product
# print answer
print(final_sum)
















#--------- Write your code above this line---------------------------