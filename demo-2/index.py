import threading
import os
  
 
def print_cube(num):
    # function to print cube of given num
    print("Cube: {}" .format(num * num * num))
 
 
def print_square(num):
    os.system("node ./client2.js")
    
 
 
if __name__ =="__main__":
    while True:
        threading.Thread(target=print_square, args=(10,)).run()