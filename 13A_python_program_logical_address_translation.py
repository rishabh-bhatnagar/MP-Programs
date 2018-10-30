from random import shuffle as jumble
memory_size = 100


print("Logical address to physical address : ")
seg_size  = int(input("Enter the size of segment : "))
page_size = int(input("Enter the page size : "))

if page_size > seg_size : raise ValueError("page size has to be greater than segment size.")
n_pages = int(seg_size / page_size)

mm = list(range(n_pages))
jumble(mm)                #mm : main memory.


print("Structure of Main Memory : \n\n")
print("\n".join(["     {}       \t{}".format(i, mm[i]) for i in range(n_pages)]))

l_addr = int(input("Enter the logical address : "))
page_no = int(input("Enter the page number : "))
offset = int(input("Enter the offset : "))

if page_no > n_pages or offset > page_size : print("Invalid logical address.")

p_address = mm.index(page_no)*page_size + offset
print("Physical address is :", p_address)
