#!/bin/python3
import tkinter as tk

root = tk.Tk()
root.title("DummyWindow")
root.geometry("300x100")
label = tk.Label(root, text="Dummy Window")
label.pack()
root.mainloop()
